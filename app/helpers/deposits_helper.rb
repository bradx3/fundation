module DepositsHelper
  def deposit_type_options
    options = DepositType.all.map { |dt| [ dt.name, dt.id ] }
    options = [ '' ] + options
    options_for_select(options)
  end

  def accounts(transaction)
    names = transaction.account_transactions.used.map { |a| a.account.name }
    return names.sort.join(", ")
  end
end
