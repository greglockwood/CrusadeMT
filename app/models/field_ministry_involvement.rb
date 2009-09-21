class FieldMinistryInvolvement < ActiveRecord::Base
  belongs_to :field_ministry
  belongs_to :client

  validates_presence_of :client
  validates_presence_of :field_ministry
  validates_presence_of :start_date
  
end
