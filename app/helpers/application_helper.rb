module ApplicationHelper
  def currency(amount)
    number_to_currency(amount)
  end

  def link_class(expected_controller_name)
    return "active" if expected_controller_name == controller_name
  end
end
