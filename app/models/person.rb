class Person < ActiveRecord::Base
  include Shared::FullAddress
  belongs_to :church
  belongs_to :workplace
  belongs_to :spouse, :class_name => 'Person'
  belongs_to :state
  
  has_one :client
  has_many :children, :class_name => 'Person', :foreign_key => 'parent_id'
  has_many :enrolments
  has_many :degrees, :through => :enrolments
  has_many :students
  has_many :schools, :through => :students
  has_many :primary_schools, :through => :students, :source => :school
  has_many :high_schools, :through => :students, :source => :school
  has_many :universities, :through => :students, :source => :school
  has_many :life_events
  has_many :upcoming_events, :class_name => 'LifeEvent', :foreign_key => 'person_id', :conditions => "event_date > '#{Date.today.to_s(:db)}'"
  
  validates_presence_of :first_name
  validates_inclusion_of :gender, :in => %w( male female unknown ), :allow_nil => true, :message => "gender {{value}} is not a valid gender."
  
  def age
    # return whatever is in the age field, unless date_of_birth is set,
    # in which case we can calculate the actual age exactly
    return read_attribute(:age) unless date_of_birth
    # following mostly stolen from this page: http://www.ruby-forum.com/topic/49265
    day_diff = Date.today - date_of_birth.day
    month_diff = Date.today.month - date_of_birth.month - (day_diff < 0 ? 1 : 0)
    Date.today.year - date_of_birth.year - (month_diff < 0 ? 1 : 0)
  end
  
  def full_name
    [first_name, last_name].compact.join(" ")
  end
    
  def full_name_including_nickname
    name = []
    name << first_name unless !first_name?
    name << "(#{nickname})" unless !nickname?
    name << last_name unless !last_name
    name.join " "
  end
  
  def to_param
    # have the url parameter include their name
    "#{id}-#{full_name.gsub(/[^A-Za-z]/, '-')}" # the regex may not be ideal, may need some other allowed chars as well
  end
end
