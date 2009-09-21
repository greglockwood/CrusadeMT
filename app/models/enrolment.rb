class Enrolment < ActiveRecord::Base
  belongs_to :person
  belongs_to :degree

  validates_presence_of :person
  validates_presence_of :degree
end
