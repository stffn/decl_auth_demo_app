class Conference < ActiveRecord::Base
  # Activate model authorization by calling using_access_control.
  # Every create, update, destroy will be checked and an exception raised
  # if not allowed.  For performance reasons, read isn't checked by default,
  # but may be enabled as an option.
  using_access_control
  
  has_many :talk_objs, :class_name => "Talk"
  has_many :conference_attendees
  has_many :attendees, :through => :conference_attendees, :source => :user
  
  def is_attended_by? (user)
    not attendence_of(user).nil?
  end
  
  def attendence_of (user)
    conference_attendees.find_by_user_id(user)
  end
  
  def talks
    talk_objs
  end
end
