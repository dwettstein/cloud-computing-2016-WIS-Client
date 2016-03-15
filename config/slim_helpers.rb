module SlimHelpers
  def param_input(name, array=false)
    name += '[]' if array
    "<div class=\"input-group\">
      <span class=\"input-group-addon\" id=\"basic-addon-#{name}\">#{name}</span>
      <input aria-describedby=\"basic-addon-#{name}\" class=\"form-control\" name=\"#{name}\" type=\"text\">
    </div>"
  end
end
