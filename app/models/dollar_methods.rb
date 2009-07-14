module DollarMethods
  def dollar_method
    if self.respond_to?(:amount_in_cents)
      return :amount_in_cents
    elsif self.respond_to?(:initial_balance_in_cents)
      return :initial_balance_in_cents
    end
  end

  def dollars=(amount)
    self.send("#{ dollar_method }=", amount.to_f * 100.0)
  end

  def dollars
    return self.send(dollar_method).to_f / 100.0
  end
end
