require 'test_helper'

class FieldMinistryTest < ActiveSupport::TestCase
  # ensure relationship exists
  test "FieldMinistry has a field_ministry_involvements field" do
    assert(FieldMinistry.responds_to?('field_ministry_involvements'), "FieldMinistry does not have a field_ministry_involvements field (has the relationship been set?).")
  end

end
