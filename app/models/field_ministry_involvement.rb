class FieldMinistryInvolvement < ActiveRecord::Base
  belongs_to :field_ministry
  belongs_to :client
end
