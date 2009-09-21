class School < ActiveRecord::Base
  belongs_to :state
  
  has_many :degrees, :class_name => 'Degree', :foreign_key => 'university_id'
  has_many :people, :through => :students
  
  validates_presence_of :name
  validates_inclusion_of :school_type, :in => ["primary_school", "high_school", "university"], :message => "school type of {{value}} is not valid."
end
