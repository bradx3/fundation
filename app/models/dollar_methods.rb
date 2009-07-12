module DollarMethods
  def dollars=(amount)
    self.amount_in_cents = amount * 100.0
  end

  def dollars
    return self.amount_in_cents / 100.0
  end
end
