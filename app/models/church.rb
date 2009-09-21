require 'shared_modules'

class Church < ActiveRecord::Base
  include Shared::FullAddress
  belongs_to :state
end
