class CreateTalks < ActiveRecord::Migration
  def self.up
    create_table :talks do |t|
      t.string :title
      t.references :user
      t.text :abstract
      t.datetime :start
      t.references :conference

      t.timestamps
    end
  end

  def self.down
    drop_table :talks
  end
end
