require "vendor/plugins/declarative_authorization/lib/declarative_authorization/maintenance"

class AddFirstUser < ActiveRecord::Migration
  def self.up
    Authorization::Maintenance::without_access_control do
      u = User.create(:login => 'first', :email => 'bla@bla.de',
        :password => 'blabla', :password_confirmation => 'blabla')
      p u
      u.save!
    end
  end

  def self.down
    Authorization::Maintenance::without_access_control do
      u = User.find_by_login("first")
      u.destroy if u
    end
  end
end
