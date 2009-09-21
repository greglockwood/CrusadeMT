require 'test_helper'

class EnrolmentTest < ActiveSupport::TestCase
  # relationships
  test "enrolment has a degree property" do
    enrolment = create
    assert(enrolment.respond_to?('degree'), "enrolment does not have a degree property (has the relationship been set?)")
  end
  
  test "enrolment has a person property" do
    enrolment = create
    assert(enrolment.respond_to?('person'), "enrolment does not have a person property (has the relationship been set?).")
  end
  
  # required fields
  test "degree is required for enrolment" do
    no_degree = create({:degree => nil})
    assert(!no_degree.valid?, "enrolment should not be valid when degree is nil.")
  end
  
  test "person is required for enrolment" do
    no_person = create({:person => nil})
    assert(!no_person.valid?, "enrolment should not be valid when person is nil.")
  end
  
  # test default values
  test "default values for enrolment are valid" do
    default = create
    assert(default.valid?, "Default values are not valid for enrolment. Double check @@enrolment_default_values in test_helper.rb.")
  end
  
private
  def create(options={})
    Enrolment.create(@@enrolment_default_values.merge(options))
  end
end
