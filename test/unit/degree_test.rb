require 'test_helper'

class DegreeTest < ActiveSupport::TestCase
  # relationships
  test "degree has a university property" do
    degree = create
    assert(degree.respond_to?('university'), "Degree does not have a university property (has the relationship been set?)")
    begin
      degree.university
    rescue
      assert(false, "university property is throwing an error")
    end
  end
  
private
  def create(options={})
    Degree.create(@@degree_default_values.merge(options))
  end
end
