module FormsHelper
  def submit_button_for(form)
    text = form.object.new_record? ? "Create" : "Update"
    return form.submit(text, :class => "button")
  end

end
