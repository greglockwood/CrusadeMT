require 'test_helper'

class ChurchTest < ActiveSupport::TestCase

  test "church has a full_address virtual attribute" do
    assert(Church.respond_to?('full_address'), "Church does not have a full_address virtual attribute yet.")
    # TODO Check it is the correct format, etc
  end
  
  
end
