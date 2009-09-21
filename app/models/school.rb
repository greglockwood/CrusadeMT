class School < ActiveRecord::Base
  include Shared::FullAddress
  
  belongs_to :state
  
  has_many :degrees, :class_name => 'Degree', :foreign_key => 'university_id'
  has_many :students
  has_many :people, :through => :students
  
  validates_presence_of :name
  #validates_inclusion_of :schooltype, :in => ["primary_school", "high_school", "university"], :message => "school type of {{value}} is not valid."
end

