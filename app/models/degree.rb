class Degree < ActiveRecord::Base
  belongs_to :university, :class_name => 'School', :foreign_key => 'university_id'
  
  has_many :people
end
