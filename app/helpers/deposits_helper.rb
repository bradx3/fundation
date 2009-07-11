module DepositsHelper
  def deposit_type_options
    options = DepositType.all.map { |dt| [ dt.name, dt.id ] }
    options = [ '' ] + options
    options_for_select(options)
  end
end
