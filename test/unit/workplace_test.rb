require 'test_helper'

class WorkplaceTest < ActiveSupport::TestCase
  test "workplace has full_address virtual attribute" do
    assert(Workplace.respond_to?('full_address'), "Workplace does not have a full_address virtual attribute yet.")
    # TODO Check it is the correct format, etc    
  end
end
