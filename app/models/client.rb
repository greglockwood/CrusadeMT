class Client < ActiveRecord::Base
  belongs_to :person
  
  has_many :field_ministry_involvements
  has_many :field_ministries, :through => :field_ministry_involvements
  
  validates_presence_of :person
end
