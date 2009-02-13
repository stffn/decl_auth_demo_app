require 'test_helper'

class ConferencesTest < ActiveSupport::TestCase
  def test_should_create
    assert_difference "Conference.count" do
      c = Conference.new(:title => "test", :location => "test")
      with_user users(:conf_org) do
        c.save
      end
    end
  end

  def test_should_not_create
    assert_raise Authorization::NotAuthorized do
      c = Conference.new(:title => "test", :location => "test")
      with_user users(:user) do
        c.save
      end
    end
  end
end
