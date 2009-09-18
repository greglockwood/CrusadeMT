require 'test_helper'

class StateTest < ActiveSupport::TestCase
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
  
end
