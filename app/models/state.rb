class State < ActiveRecord::Base
  has_many :workplaces
  has_many :churches
  has_many :people
  has_many :schools
  
  validates_presence_of :name
  validates_presence_of :abbreviation
end
