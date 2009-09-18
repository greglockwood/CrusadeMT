class Person < ActiveRecord::Base
  belongs_to :church
  belongs_to :workplace
end
