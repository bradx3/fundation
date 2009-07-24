class Deposit < Transaction
  validate :allocations_add_to_total
  validate :amount_greater_than_zero

  private

  def amount_greater_than_zero
    if dollars.to_f == 0.0
      self.errors.add_to_base("Can't deposit no money")
    end
  end

end
