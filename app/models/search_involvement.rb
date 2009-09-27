class SearchInvolvement < ActiveRecord::Base
  belongs_to :search
  belongs_to :field_ministry
end
