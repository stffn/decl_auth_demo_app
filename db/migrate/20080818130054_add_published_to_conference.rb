class AddPublishedToConference < ActiveRecord::Migration
  def self.up
    add_column :conferences, :published, :boolean
  end

  def self.down
    remove_column :conferences, :published
  end
end
