class Talk < ActiveRecord::Base
  belongs_to :conference
  belongs_to :user
  has_many :talk_attendees
  has_many :attendees, :through => :talk_attendees, :source => :user
  
  validates_associated :user, :conference
  validates_presence_of :user, :conference
  
  def is_attended_by? (user)
    not attendence_of(user).nil?
  end
  
  def attendence_of (user)
    talk_attendees.find_by_user_id(user)
  end
end
