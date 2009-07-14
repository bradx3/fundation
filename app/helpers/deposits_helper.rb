module DepositsHelper
  def deposit_template_options
    options = DepositTemplate.all.map { |dt| [ dt.name, dt.id ] }
    options = [ '' ] + options
    options_for_select(options)
  end

  def funds(transaction)
    names = transaction.fund_transactions.used.map { |a| a.fund.name }
    return names.sort.join(", ")
  end
end
