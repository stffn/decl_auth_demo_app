ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
# For declarative_authorization test helpers
require File.expand_path(File.dirname(__FILE__) +
    "/../vendor/plugins/declarative_authorization/lib/declarative_authorization/maintenance")

class ActiveSupport::TestCase
  # We need to include the declarative_authorization helpers
  include Authorization::TestHelper

  # standard Rails testing setup
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all

  # It might help to have helper methods for users from different roles
  def admin
    users(:admin)
  end
end
