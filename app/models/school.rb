class School < ActiveRecord::Base
  belongs_to :state
  
  has_many :degrees, :class_name => 'Degree', :foreign_key => 'university_id'
end
