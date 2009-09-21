require 'test_helper'

class SchoolTest < ActiveSupport::TestCase
  # relationships
  test "school has a people property" do
    school = create
    assert(school.respond_to?('people'), "school does not have a people property (has the relationship been set?)")
    begin
      school.people
    rescue
      assert(false, "people property is throwing an error")
    end    
  end

  test "school has a degrees property" do
    school = create
    assert(school.respond_to?('degrees'), "school does not have a degrees property (has the relationship been set?)")
    begin
      school.degrees
    rescue
      assert(false, "degrees property is throwing an error")
    end
  end
  
  # required fields
  test "name is required for school" do
    no_name = create({:name => nil})
    assert(!no_name.valid?, "school should not be valid if name is nil.")
    blank_name = create({:name => ""})
    assert(!blank_name.valid?, "school should not be valid if name is empty.")
  end
  
  # ensure default values work
  test "default values for school are valid" do
    default = create
    assert(default.valid?, "Default values for school are not valid. Double check the @@school_default_values in test_helper.rb.")
  end
  
  # other fields
  test "school has a full_address property" do
    school = create
    test_full_address(school) # test helper method
  end  
  
private
  def create(options={})
    HighSchool.create(@@school_default_values.merge(options))
  end
end
