require 'test_helper'

class WorkplaceTest < ActiveSupport::TestCase
  # other fields
  test "workplace has a full_address property" do
    workplace = create
    test_full_address(workplace) # test helper method
  end
  
private
  
  def create(options={})
    Workplace.create(@@workplace_default_values.merge(options))
  end
end
