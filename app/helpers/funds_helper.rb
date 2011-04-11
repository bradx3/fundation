module FundsHelper
  def options_for_funds_select(selected = nil)
    options = current_user.family.funds.active.map { |f| [ f.name, f.id ] }
    options_for_select(options, selected.to_i)
  end
end
