class Student < ActiveRecord::Base
  belongs_to :person
  belongs_to :school

  validates_presence_of :person
  validates_presence_of :school
end
