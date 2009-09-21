ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  # default values for various classes. kind of like simple fixtures for tests.
  @@person_default_values = {
    :first_name => "Bruce"
  }

  @@client_default_values = {
    :person => Person.create(@@person_default_values)
  }
  
  @@field_ministry_default_values = {
    :name => "My Field Ministry",
    :xml_url => "http://google.com/"
  }
  
  @@field_ministry_involvement_default_values = {
    :client => Client.create(@@client_default_values),
    :field_ministry => FieldMinistry.create(@@field_ministry_default_values),
    :start_date => 1.year.ago
  }
  
  @@church_default_values = {
    :name => "My Church"
  }
  
  @@school_default_values = {
    :name => "Derek Zoolander School for Kids Who Want To Learn to Read Good (and Do Other Things Good, too)",
    # I'm pretty sure that's not the correct line, but it's close enough for some test data.
    :school_type => "high_school"
  }
  
  @@degree_default_values = {
    :name => "Bachelor of Attendance",
    :university => School.create(@@school_default_values)
  }
  
  @@workplace_default_values = {
    :name => "Microgooglesoft Inc"
  }
  
  @@student_default_values = {
    :person => Person.create(@@person_default_values),
    :school => School.create(@@school_default_values)
  }
  
  @@enrolment_default_values = {
    :person => Person.create(@@person_default_values),
    :degree => Degree.create(@@degree_default_values)
  }
  
  @@life_event_default_values = {
    :person => Person.create(@@person_default_values),
    :description => "Marriage",
    :event_date => 1.week.from_now
  }
  
  @@state_default_values = {
    :name => "New South Wales",
    :abbreviation => "NSW"
  }  
  
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  # test that a particular model object has a full_address property and that it is set correctly
  def test_full_address(model)
    assert(model.respond_to?('full_address'), "#{model.class} does not have a full_address property.")
    address_test_all_values = { 
      :address1 => 'ADDRESS1', 
      :address2 => 'ADDRESS2',
      :address3 => 'ADDRESS3',
      :state => State.create({:name => "STATE_NAME", :abbreviation => "STA"}),
      :suburb => "SUBURB",
      :postcode => "9999"
    }
    # test when all values present 
    model.attributes = address_test_all_values
    assert_equal("ADDRESS1\nADDRESS2\nADDRESS3\nSUBURB STA 9999", model.full_address)
    # test when address1 is blank
    model.attributes = address_test_all_values.merge({:address1 => nil})    
    assert_equal("ADDRESS2\nADDRESS3\nSUBURB STA 9999", model.full_address)
    model.attributes = address_test_all_values.merge({:address1 => ""})    
    assert_equal("ADDRESS2\nADDRESS3\nSUBURB STA 9999", model.full_address)
    # test when address2 is blank
    model.attributes = address_test_all_values.merge({:address2 => nil})
    assert_equal("ADDRESS1\nADDRESS3\nSUBURB STA 9999", model.full_address)
    model.attributes = address_test_all_values.merge({:address2 => ""})
    assert_equal("ADDRESS1\nADDRESS3\nSUBURB STA 9999", model.full_address)
    # test when address3 is blank
    model.attributes = address_test_all_values.merge({:address3 => nil})
    assert_equal("ADDRESS1\nADDRESS2\nSUBURB STA 9999", model.full_address)    
    model.attributes = address_test_all_values.merge({:address3 => ""})
    assert_equal("ADDRESS1\nADDRESS2\nSUBURB STA 9999", model.full_address)
  end
  
end
