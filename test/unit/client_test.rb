require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  # relationships
  test "client has an associated person property" do
    assert(Client.respond_to?('person'), "Client does not have a person property (has the relationship been declared?).") 
  end
  
  test "client has a field_ministry_involvements field" do
    assert(Client.respond_to?('field_ministry_involvements'), "Client does not have a field_ministry_involvements property (has the relationship been declared?)")
  end
  
  # ensure scoped fields exist
  test "client has upcoming_events property" do
    assert(Client.respond_to?('upcoming_events'), "Client does not have an upcoming_events property yet.")
  end
  
  # required fields
  test "client requires person property to be set" do
    no_person = create({:person => nil})
    assert(!no_person.valid?, "Client should be invalid when person is nil:\n#{no_person.to_yaml}")
  end
  
  # make sure the default values work okay
  test "default client values are valid" do
    default = create
    assert(default.valid?, "Client is invalid for default values. Check @@client_default_values in test_helper.rb.")
  end
  
private
  def create(options={})
    Client.create(@@client_default_values.merge(options))
  end
end
