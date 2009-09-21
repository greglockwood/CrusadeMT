require 'test_helper'

class ChurchTest < ActiveSupport::TestCase

  test "church has a full_address property" do
    church = create
    test_full_address(church) # test helper method
  end
  
private
  def create(options={})
    Church.create(@@church_default_values.merge(options))
  end
end
