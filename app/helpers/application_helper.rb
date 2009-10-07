# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def yes_or_no(bool_value)
    bool_value ? "Yes" : "No"
  end
  
  def divider
    case setting("section_divider")
    when "horizontal_line"
       "<div class='divider'></div>"
    when "blank_paragraph"
      "<p>&nbsp;</p>"
    else 
      ""
    end
  end
  
  def blank_text(text)
    if setting("show_text_when_field_is_blank") == "yes"
      text
    else
      ""
    end
  end
  
  def value_or_blank(value, blank_string = "N/A", blank_test = nil)
    is_blank = (blank_test.nil? ? (value.nil? or value.blank?) : blank_test.call)
    if is_blank
      blank_text(blank_string)
    else
      value
    end
  end
  
  def value_or_blank_object(object, value_method, blank_string = "N/A", blank_method = nil)
    is_blank = (blank_method.nil? ? (value.nil? or value.blank?) : object.send(blank_method.to_s))
    if is_blank
      blank_text(blank_string)
    else
      object.send(value_method.to_s)
    end
  end
  
  def link_to_or_blank_object(object, value_method, blank_string = "N/A", blank_method = nil)
    is_blank = (blank_method.nil? ? (value.nil? or value.blank?) : object.send(blank_method.to_s))
    if is_blank
      blank_text(blank_string)
    else
      link_to object.send(value_method.to_s), object
    end
  end

  
  def unimplemented_section(&block)
    if setting("show_unimplemented_features") == "yes"
      concat(capture(&block))
    else
      ""
    end
  end
  
end
