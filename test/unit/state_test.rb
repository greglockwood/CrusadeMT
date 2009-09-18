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
    assert_equal(aus_states.sort, States.all.collect( |state| [state.name, state.abbreviation]).sort)
  end
  
end
