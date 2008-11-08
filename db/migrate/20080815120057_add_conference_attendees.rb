class AddConferenceAttendees < ActiveRecord::Migration
  def self.up
    create_table :conference_attendees do |t|
      t.references :user
      t.references :conference
    end
  end

  def self.down
    drop_table :conference_attendees
  end
end
