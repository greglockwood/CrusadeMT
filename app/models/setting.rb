class Setting < ActiveRecord::Base
  def options_array
    # returns options as an array (split by space)
    options.split(' ')
  end
  
  def options_array_for_select_helper
    array = Array.new
    options_array.each do |option|
      array.push [option.titleize, option]
    end
    array
  end
end
