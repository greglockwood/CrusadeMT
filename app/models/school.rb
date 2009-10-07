class School < ActiveRecord::Base
  include Shared::FullAddress
  
  belongs_to :state
  
  has_many :degrees, :class_name => 'Degree', :foreign_key => 'university_id'
  has_many :students
  has_many :people, :through => :students
  
  validates_presence_of :name
  
  def to_param
    # have the url parameter include the name
    "#{id}-#{name.gsub(/[^A-Za-z]/, '-')}" # the regex may not be ideal, may need some other allowed chars as well
  end
end

