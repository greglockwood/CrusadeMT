class LifeEvent < ActiveRecord::Base
  belongs_to :person

  validates_presence_of :person
  validates_presence_of :description
  validates_presence_of :event_date
end
