require 'test_helper'

class AuthorizationTest < ActiveSupport::TestCase
  def test_no_guest_can_modify
    assert users_of_role(:guest).cannot :update, :conferences
    assert users_of_role(:admin).can :update, :conferences
    assert only_users_of_role(:admin, :conference_organizer).can :update, :conferences
  end

  protected
  def users_of_role (*roles)
    @roles_for_checks = roles
    self
  end

  def only_users_of_role (*roles)
    @roles_for_checks = Authorization::Engine.instance.roles - roles
    result_flip!
    self
  end

  def can (operation, context)
    res = Authorization::Engine.instance.permit?(operation,
      :context => context, :user => user_for_role(@roles_for_checks))
    result_flip? ? !res : res
  end

  def cannot (operation, context)
    res = !Authorization::Engine.instance.permit?(operation,
      :context => context, :user => user_for_role(@roles_for_checks))
    result_flip? ? !res : res
  end

  def user_for_role (roles)
    User.new(:roles => roles)
  end

  def result_flip!
    @result_flip = !@result_flip
  end

  def result_flip?
    !!@result_flip
  end
end