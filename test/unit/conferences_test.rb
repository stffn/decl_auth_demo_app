require 'test_helper'

class ConferencesTest < ActiveSupport::TestCase
  def test_should_create
    #assert @conferences["one"]
    assert_difference "Conference.count" do
      c = Conference.new(:title => "test", :location => "test")
      without_access_control do
        c.save
      end
    end
  end
end
