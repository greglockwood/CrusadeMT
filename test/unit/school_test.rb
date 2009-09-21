require 'test_helper'

class SchoolTest < ActiveSupport::TestCase
  # relationships
  test "school has a people property" do
    school = create
    assert(school.respond_to?('people'), "school does not have a people property (has the relationship been set?)")
  end

  test "school has a degrees property" do
    school = create
    assert(school.respond_to?('degrees'), "school does not have a degrees property (has the relationship been set?)")
  end
  
  # required fields
  test "name is required for school" do
    no_name = create({:name => nil})
    assert(!no_name.valid?, "school should not be valid if name is nil.")
    blank_name = create({:name => ""})
    assert(!blank_name.valid?, "school should not be valid if name is empty.")
  end
  
  test "type is required for school" do
    nil_type = create({:school_type => nil})
    assert(!nil_type.valid?, "school should not be valid if type is nil.")
    blank_type = create({:school_type => ""})
    assert(!blank_type.valid?, "school should not be valid if type is blank.")
  end
  
  test "invalid types cause school to be invalid" do
    bad_type1 = create({:school_type => "sausage"})
    bad_type2 = create({:school_type => "narwhal"})
    assert(!bad_type1.valid?, "school should not be valid for invalid value of type.")
    assert(!bad_type2.valid?, "school should not be valid for invalid value of type.")    
  end
  
  test "allowed types are valid" do
    primary = create({:school_type => "primary_school"})
    high = create({:school_type => "high_school"})
    uni = create({:school_type => "university"})
    assert(primary.valid?, "school should be valid for type of primary_school.")
    assert(high.valid?, "school should be valid for type of high_school.")
    assert(uni.valid?, "school should be valid for type of university.")
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
    School.create(@@school_default_values.merge(options))
  end
end
