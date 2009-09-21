class Enrolment < ActiveRecord::Base
  belongs_to :person
  belongs_to :degree
end
