# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def currency(amount)
    number_to_currency(amount)
  end
end
