require 'test_helper'

class ConferenceAttendeesTest < ActiveSupport::TestCase
  def test_should_create
    assert_difference "ConferenceAttendee.count" do
      with_user users(:user) do
        conferences(:public).conference_attendees.create!(:user => users(:user))
      end
    end
  end

  def test_should_not_create_different_user
    assert_raise Authorization::NotAuthorized, Authorization::AttributeAuthorizationError do
      with_user users(:user) do
        conferences(:public).conference_attendees.create(:user => users(:quentin))
      end
    end
  end

  def test_should_not_create_unpublished_conference
    assert_raise Authorization::NotAuthorized, Authorization::AttributeAuthorizationError do
      with_user users(:user) do
        conferences(:two).conference_attendees.create(:user => users(:user))
      end
    end
  end
end
