class ConferenceAttendee < ActiveRecord::Base
  using_access_control
  
  belongs_to :user
  belongs_to :conference
  validates_presence_of :user, :conference
  validates_associated :user, :conference
end
