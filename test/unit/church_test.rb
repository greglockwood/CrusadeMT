require 'test_helper'

class ChurchTest < ActiveSupport::TestCase

  test "church has a full_address virtual attribute" do
    church = create
    assert(church.respond_to?('full_address'), "Church does not have a full_address virtual attribute yet.")
    # TODO Check it is the correct format, etc
  end
  
private
  def create(options={})
    Church.create(@@church_default_values.merge(options))
  end
end
