class TalkAttendee < ActiveRecord::Base
  using_access_control
  
  belongs_to :user
  belongs_to :talk
  validates_presence_of :user, :talk
  validates_associated :user, :talk
end
