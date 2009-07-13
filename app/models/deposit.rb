class Deposit < Transaction
  validate :allocations_add_to_total
  validate :amount_greater_than_zero

  def allocated_dollars
    account_transactions.inject(0) { |total, da| total += da.dollars }    
  end

  private

  def amount_greater_than_zero
    if dollars.to_f == 0.0
      self.errors.add_to_base("Can't deposit no money")
    end
  end

  def allocations_add_to_total
    if allocated_dollars != dollars
      self.errors.add_to_base("All money hasn't been allocated")
    end
  end
end
