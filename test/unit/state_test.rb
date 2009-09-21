require 'test_helper'

class StateTest < ActiveSupport::TestCase
  # relationships
  test "state has a workplaces property" do
    state = create
    assert(state.respond_to?('workplaces'), "State doesn't have a workplaces property (has the relationship been set?)")
  end
  
  test "state has a churches property" do
    state = create
    assert(state.respond_to?('churches'), "State doesn't have a churches property (has the relationship been set?)")
  end
  
  test "state has a people property" do
    state = create
    assert(state.respond_to?('people'), "State doesn't have a people property (has the relationship been set?)")
  end
  
  test "state has a schools property" do
    state = create
    assert(state.respond_to?('schools'), "State doesn't have a schools property (has the relationship been set?)")
  end
  
  # required fields
  test "name is required for a state" do
    nil_name = create({:name => nil})
    assert(!nil_name.valid?, "State should be invalid when name is nil.")
    blank_name = create({:name => ""})
    assert(!blank_name.valid?, "State should be invalid when name is blank.")    
  end
  
  test "abbreviation is required for a state" do
    nil_abbrev = create({:abbreviation => nil})
    assert(!nil_abbrev.valid?, "State should be invalid when abbreviation is nil.")
    blank_abbrev = create({:abbreviation => ""})
    assert(!blank_abbrev.valid?, "State should be invalid when abbreviation is blank.")
  end
  
  # default values
  test "default values for state are valid" do
    default = create
    assert(default.valid?, "Default values for state are invalid. Double check @@state_default_values in test_helper.rb.")
  end
  
  
  test "all australian states are included" do
    aus_states = [["Australian Capitol Territory", "ACT"], 
    ["New South Wales", "NSW"], 
    ["Northern Territory", "NT"], 
    ["South Australia","SA"], 
    ["Tasmania","TAS"], 
    ["Victoria","VIC"],
    ["Western Australia","WA"]]
    assert_equal(7, State.count, "There are not seven states in the database. Have you run 'rake db:populate:states' yet?")
    assert_equal(aus_states.sort, State.all.collect{ |state| [state.name, state.abbreviation]}.sort)
  end

private
  def create(options={})
    State.create(@@state_default_values.merge(options))
  end
end
