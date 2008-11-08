class CreateTalkAttendees < ActiveRecord::Migration
  def self.up
    create_table :talk_attendees do |t|
      t.integer :talk_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :talk_attendees
  end
end
