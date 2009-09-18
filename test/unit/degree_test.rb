require 'test_helper'

class DegreeTest < ActiveSupport::TestCase
  # relationships
  test "degree has a university property" do
    assert(Degree.responds_to?('university'), "Degree does not have a university property (has the relationship been set?)")
  end
  
end
