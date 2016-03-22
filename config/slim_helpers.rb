module SlimHelpers
  
  def param_input(friendly_name, name, default_value="", array=false)
    name += '[]' if array
    "<div class=\"input-group\">
      <span class=\"input-group-addon\" id=\"basic-addon-#{name}\">#{friendly_name}</span>
      <input aria-describedby=\"basic-addon-#{name}\" class=\"form-control\" name=\"#{name}\" type=\"text\" value=\"#{default_value}\">
    </div>"
  end
  
  # Created a slim helper for a dropdown input field for the forms.
  def dropdown_input(friendly_name, name, dropdown_elements, has_empty_element, default_element=-1)
    @options_string = has_empty_element ? "<option></option>" : ""
    for i in 0..(dropdown_elements.length-1)
      @options_string += "<option value='#{dropdown_elements[i]}'" + (i == default_element ? "selected=\"selected\"" : "") + ">" + dropdown_elements[i].to_s + "</option>"
    end
    "<div class=\"input-group\">
      <span class=\"input-group-addon\" id=\"basic-addon-#{name}\">#{friendly_name}</span>
      <select class=\"form-control\" name=\"#{name}\">" + @options_string + "</select>
    </div>"
  end
  
end
