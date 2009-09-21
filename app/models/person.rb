class Person < ActiveRecord::Base
  belongs_to :church
  belongs_to :workplace
  belongs_to :spouse, :class_name => 'Person'
  
  has_one :client
  has_many :children, :class_name => 'Person', :foreign_key => 'parent_id'
  has_many :degrees, :through => :enrolments
  has_many :universities, :through => :degrees
  
  validates_presence_of :first_name
  
  
  def age
    # return whatever is in the age field, unless date_of_birth is set,
    # in which case we can calculate the actual age exactly
    return age unless date_of_birth
    # following mostly stolen from this page: http://www.ruby-forum.com/topic/49265
    day_diff = Date.today - date_of_birth.day
    month_diff = Date.today.month - date_of_birth.month - (day_diff < 0 ? 1 : 0)
    Date.today.year - date_of_birth.year - (month_diff < 0 ? 1 : 0)
  end
end
