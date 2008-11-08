class AddRolesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :roles, :text
  end

  def self.down
    remove_column :users, :roles
  end
end
