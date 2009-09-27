# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def yes_or_no(bool_value)
    bool_value ? "Yes" : "No"
  end
  
  def divider
    params[:divider] ||= "line"
    case params[:divider]
    when "line"
      "<div class='divider'></div>"
    when "blanks"
      "<p>&nbsp;</p>"
    end
  end
end
