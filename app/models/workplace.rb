class Workplace < ActiveRecord::Base
  include Shared::FullAddress
  belongs_to :state
  
  has_many :people
  
  def to_param
    # have the url parameter include the name
    "#{id}-#{name.gsub(/[^A-Za-z]/, '-')}" # the regex may not be ideal, may need some other allowed chars as well
  end
end
