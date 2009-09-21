class FieldMinistry < ActiveRecord::Base
  has_many :field_ministry_involvements
  has_many :clients, :through => :field_ministry_involvements
  
end
