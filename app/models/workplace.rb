class Workplace < ActiveRecord::Base
  include Shared::FullAddress
  belongs_to :state
end
