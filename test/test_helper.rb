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
end
