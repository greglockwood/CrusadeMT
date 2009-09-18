require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # relationships
  test "person has a spouse property" do
    assert(Person.responds_to?('spouse'), "Person does not have a spouse property (has the relationship been set?).")
  end
  
  test "person has a children property" do
    # to make this test pass, the following section of the Rails Guides might be useful: http://guides.rubyonrails.org/association_basics.html#creating-join-tables-for-has-and-belongs-to-many-associations
    assert(Person.responds_to?('children'), "Person does not have a children property (has the relationship been set and the association table created?)")
  end
  
  test "person has a home_church property" do
    # to make this pass, I think I'll need to make sure I specify the right foreign key, etc
    assert(Person.responds_to?('home_church'), "Person does not have a home_church property (has the relationship been set up correctly?)")
  end
  
  test "person has a primary_schools property" do
    # this will prob be a virtual attribute
    assert(Person.responds_to?('primary_schools'), "Person does not have a primary_schools property (has it been created?).")
  end
  
  test "person has a high_schools property" do
    # this will prob be a virtual attribute
    assert(Person.responds_to?('high_schools'), "Person does not have a high_schools property (has it been created?).")    
  end
  
  test "person has a universities property" do
    # this will prob be a virtual attribute
    assert(Person.responds_to?('universities'), "Person does not have a universities property (has it been created?).")    
  end
  
  test "person has a field_ministry_involvements property" do
    assert(Person.responds_to?('field_ministry_involvements'), "Person does not have a field_ministry_involvements property (has the relationship been set up correctly?).")  
  end
  
  test "person has a degrees property" do
    assert(Person.responds_to?('degrees'), "Person does not have a degrees property (has the relationship been set up?).")
  end
  
  # ensure other scoped fields exist
  test "person has an email attribute" do
    assert(Person.responds_to?('email'), "Person does not have an email attribute.")
  end
  
  test "person has a nickname attribute" do
    assert(Person.responds_to?('nickname'), "Person does not have an email attribute.")
  end
  
  test "person has a gender attribute" do
    assert(Person.responds_to?('gender'), "Person does not have a gender attribute.")
  end
  
  test "person has a full_address virtual attribute" do
    assert(Person.responds_to?('full_address'), "Person does not have a full_address virtual attribut yet.")
    # TODO Check contents of attribute are correct
  end
  
  # required fields
  test "person must have at least a first name" do
    no_fname = create({:first_name => nil})
    assert(!no_fname.valid?, "Person should be invalid if first_name is nil.")
    no_fname = create({:first_name => ''})
    assert(!no_fname.valid?, "Person should be invalid if first_name is blank.")
  end
  
  # make sure default values create a valid record
  test "default values for person are valid" do
    default = create
    assert(default.valid?, "Default values for person are invalid. Check @@person_default_values in test_helper.rb.")
  end
  
  # age and date of birth tests
  test "person has date of birth field" do
    assert(Person.responds_to?('date_of_birth'), "Person does not have a date_of_birth field.")
  end
  
  test "age is calculated from DOB if present" do
    p = create({:date_of_birth => 7.years.ago})
    assert_equal(7, p.age)
  end
  
  # TODO More date tests
private
  def create(options={})
    Person.create(@@person_default_values.merge(options))
  end
end
