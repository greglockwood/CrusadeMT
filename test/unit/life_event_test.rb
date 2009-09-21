require 'test_helper'

class LifeEventTest < ActiveSupport::TestCase
  # relationships
  test "life event has a person property" do
    life_event = create
    assert(life_event.respond_to?('person'), "life_event does not have a person property (has the relationship been set?).")
  end
  
  # required values
  test "description is required for life events" do
    nil_desc = create({:description => nil})
    assert(!nil_desc.valid?, "life event should be invalid when description is nil.")
    blank_desc = create({:description => ""})
    assert(!blank_desc.valid?, "life event should be invalid when description is blank.")
  end
  
  test "event_date is required for life events" do
    no_date = create({:event_date => nil})
    assert(!no_date.valid?, "life event should be invalid when event_date is nil.")
  end
  
  # ensure default values work
  test "default values for life event are valid" do
    default = create
    assert(default.valid?, "Default values for life event are invalid. Double check @@life_event_default_values in test_helper.rb.")
  end
private
  def create(options={})
    LifeEvent.create(@@life_event_default_values.merge(options))
  end
end
