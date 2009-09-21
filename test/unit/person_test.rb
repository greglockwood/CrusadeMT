require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # relationships
  test "person has a spouse property" do
    person = create
    assert(person.respond_to?('spouse'), "Person does not have a spouse property (has the relationship been set?).")
    begin
      person.spouse
    rescue
      assert(false, "spouse property is throwing an error")
    end
  end
  
  test "person has a children property" do
    # to make this test pass, the following section of the Rails Guides might be useful: http://guides.rubyonrails.org/association_basics.html#creating-join-tables-for-has-and-belongs-to-many-associations
    person = create
    assert(person.respond_to?('children'), "Person does not have a children property (has the relationship been set and the association table created?)")
    begin
      person.children
    rescue
      assert(false, "children property is throwing an error")
    end
  end
  
  test "person has a church (home church) property" do
    # to make this pass, I think I'll need to make sure I specify the right foreign key, etc
    person = create
    assert(person.respond_to?('church'), "Person does not have a church property (has the relationship been set up correctly?)")
    begin
      person.church
    rescue
      assert(false, "church property is throwing an error")
    end  
  end
  
  test "person has a primary_schools property" do
    # this will prob be a virtual attribute
    person = create
    assert(person.respond_to?('primary_schools'), "Person does not have a primary_schools property (has it been created?).")
    begin
      person.primary_schools
    rescue Exception => e
      assert(false, "primary_schools property is causing an error: #{e.to_yaml}")
    end
  end
  
  test "person has a high_schools property" do
    # this will prob be a virtual attribute
    person = create
    assert(person.respond_to?('high_schools'), "Person does not have a high_schools property (has it been created?).")    
    begin
      person.high_schools
    rescue Exception => e
      assert(false, "high_schools property is throwing an error: #{e.to_yaml}")
    end
  end
  
  test "person has a universities property" do
    # this will prob be a virtual attribute
    person = create
    assert(person.respond_to?('universities'), "Person does not have a universities property (has it been created?).")    
    begin
      person.universities
    rescue Exception => e
      assert(false, "universities property is throwing an error: #{e.to_yaml}")
    end
  end
    
  test "person has a degrees property" do
    person = create
    assert(person.respond_to?('degrees'), "Person does not have a degrees property (has the relationship been set up?).")
    begin
      person.degrees
    rescue Exception => e
      assert(false, "degrees property is throwing an error:#{e.to_yaml}")
    end
  end
  
  test "person has a life_events property" do
    person = create
    assert(person.respond_to?('life_events'), "Person does not have a life_events property (has the relationship been set?)")
    begin
      person.life_events
    rescue Exception => e
      assert(false, "life_events property is throwing an error: #{e.to_yaml}")
    end
  end
  
  test "person has upcoming_events property" do
    person = create
    assert(person.respond_to?('upcoming_events'), "Person does not have an upcoming_events property yet.")
    begin
      person.upcoming_events
    rescue Exception => e
      assert(false, "upcoming_events property is throwing an error: #{e.to_yaml}")
    end
  end
  
  # ensure other scoped fields exist
  test "person has an email attribute" do
    person = create
    assert(person.respond_to?('email'), "Person does not have an email attribute.")
  end
  
  test "person has a nickname attribute" do
    person = create
    assert(person.respond_to?('nickname'), "Person does not have an email attribute.")
  end
  
  test "person has a gender attribute" do
    person = create
    assert(person.respond_to?('gender'), "Person does not have a gender attribute.")
  end
  
  test "gender attribute only accepts valid values" do
    person = create({:gender => "both"})
    assert(!person.valid?, "Person should not be valid for a gender of 'both'")
    person = create({:gender => "male"})
    assert(person.valid?, "Person should be valid for a gender of 'male'")
    person = create({:gender => "female"})
    assert(person.valid?, "Person should be valid for a gender of 'female'.")
    person = create({:gender => "unknown"})
    assert(person.valid?, "Person should be valid for a gender of 'unknown'.")
    person = create({:gender => ""})
    assert(!person.valid?, "Person should not be valid if gender is blank.")
    person = create({:gender => nil})
    assert(person.valid?, "Person should be valid when gender is nil.")
  end

  test "person has a full_address property" do
    person = create
    test_full_address(person) # test helper method
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
    person = create
    assert(person.respond_to?('date_of_birth'), "Person does not have a date_of_birth field.")
  end
  
  test "age is calculated from DOB if present" do
    # first line is duplicated from above just to make sure this test fails if I haven't implemented the field yet
    person = create
    assert(person.respond_to?('date_of_birth'), "Person does not have a date_of_birth field.")
    p = create({:date_of_birth => 7.years.ago})
    assert_equal(7, p.age)
  end
  
  # TODO More date tests
private
  def create(options={})
    Person.create(@@person_default_values.merge(options))
  end
end
