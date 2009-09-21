require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # relationships
  test "a student has a school property" do
    student = create
    assert(student.respond_to?('school'), "student does not have a school property (has the relationship been set?)")
  end
  
  test "a student has a person property" do
    student = create
    assert(student.respond_to?('person'), "student does not have a person property (has the relationship been set?)")
  end
  
  # required fields
  test "school is required for student" do
    no_school = create({:school => nil})
    assert(!no_school.valid?, "Student is valid when required school property is nil.")
  end
  
  test "person is required for student" do
    no_person = create({:person => nil})
    assert(!no_person.valid?, "Student is valid when required person property is nil.")
  end
  
  # ensure default values are working
  test "default values for student are valid" do
    default = create
    assert(default.valid?, "Default values for student are invalid. Double check @@student_default_values in test_helper.rb.")
  end
  
private
  def create(options={})
    Student.create(@@student_default_values.merge(options))
  end
end
