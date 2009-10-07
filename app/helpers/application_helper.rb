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
      "&nbsp;"
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
    case setting("show_unimplemented_features")
    when "yes"
      concat(capture(&block))
    when "disabled"
      block_html = capture(&block)
      # set some title (hover/tooltip) text for the containing div to explain why it is grey.
      title_text = "These features are not yet implemented and have been disabled as a result. They are shown merely to illustrate planned features. You can change whether these features are displayed or not by going to the Settings page."
      # we need to manually insert the disabled attribute into form inputs and select tags
      block_html.gsub!(/<(input[^\/]+|select[^>]+)(\/)?>/, '<\1 disabled="disabled"\2>')
      # the following should insert two blank spaces (an indent) at the beginning of each line, 
      # so the source is nicely indented consistently. How perfectionist is that?!
      block_html_tabbed = block_html.split("\n").collect{ |line| "  #{line}" }.join("\n")
      concat("<div class=\"unimplemented\" title=\"#{title_text}\">\n#{block_html_tabbed}\n</div>\n")
    when "no"
      ""
    end
  end
  
end
