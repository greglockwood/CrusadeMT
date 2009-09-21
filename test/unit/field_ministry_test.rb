require 'test_helper'

class FieldMinistryTest < ActiveSupport::TestCase
  # ensure relationship exists
  test "FieldMinistry has a field_ministry_involvements field" do
    field_ministry = create
    assert(field_ministry.respond_to?('field_ministry_involvements'), "FieldMinistry does not have a field_ministry_involvements field (has the relationship been set?).")
    begin
      field_ministry.field_ministry_involvements
    rescue
      assert(false, "field_ministry_involvements property is throwing an error")
    end
  end

private

  def create(options={})
    FieldMinistry.create(@@field_ministry_default_values.merge(options))
  end
end
