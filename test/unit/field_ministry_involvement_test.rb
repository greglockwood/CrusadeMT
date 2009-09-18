require 'test_helper'

class FieldMinistryInvolvementTest < ActiveSupport::TestCase
  # ensure relationships exist
  test "FieldMinistryInvolvement has a client property" do
    assert(FieldMinistryInvolvement.respond_to?('client'), "FieldMinistryInvolvement does not have a client property (has the relationship been set?)")
  end
  
  test "FieldMinistryInvolvement has a field_ministry property" do
    assert(FieldMinistryInvolvement.respond_to?('field_ministry'), "FieldMinistryInvolvement does not have a field_ministry property (has the relationship been set?)")
  end
  
  # ensure scoped fields exist
  test "FieldMinistryInvolvement has a start_date property" do
    assert(FieldMinistryInvolvement.respond_to?('start_date'), "FieldMinistryInvolvement does not have a start_date property as scoped.")
  end
  
  test "FieldMinistryInvolvement has an end_date property" do
    assert(FieldMinistryInvolvement.respond_to?('end_date'), "FieldMinistryInvolvement does not have an end_date property as scoped.")
  end
  
  # ensure required fields are enforced
  test "FieldMinistryInvolvement requires client to be set" do
    no_client = create({:client => nil})
    assert(!no_client.valid?, "FieldMinistryInvolvement should be invalid when client is nil:\n#{no_client.to_yaml}")
  end
  
  test "FieldMinistryInvolvement requires field_ministry to be set" do
    no_fm = create({:field_ministry => nil})
    assert(!no_fm.valid?, "FieldMinistryInvolvement should be invalid when field_ministry is nil:\n#{no_fm.to_yaml}.")
  end
  
  test "FieldMinistryInvolvement requires start_date to be set" do
    no_start_date = create({:start_date => nil})
    assert(!no_start_date.valid?, "FieldMinistryInvolvement should be invalid when start_date is nil:\n#{no_start_date.to_yaml}.")
  end
  
  # test default values work okay
  test "default FieldMinistryInvolvement is valid" do
    default = create
    assert(default.valid?, "Default values for FieldMinistryInvolvement should be valid. Check the @@field_ministry_involvement_default_values in test_helper.rb.")
  end
  
private 
  def create(options={})
    FieldMinistryInvolvement.create(@@field_ministry_involvement_default_values.merge(options))
  end
end
