class Withdrawal < Transaction

  before_validation :update_amount_from_fund_transactions, :if => Proc.new { |w| !w.synchronize? }
  after_save :ensure_amounts_are_negative
  validate :amount_greater_than_zero
  validate :allocations_add_to_total, :if => Proc.new { |w| w.synchronize? }

  private

  def amount_greater_than_zero
    if dollars.to_f == 0.0
      self.errors.add_to_base("Can't withdraw no money")
    end
  end

  def update_amount_from_fund_transactions
    self.dollars = (0 - allocated_dollars.abs)
  end

  def ensure_amounts_are_negative
    fund_transactions.each do |at|
      if at.dollars > 0
        at.dollars = (0 - at.dollars) 
        at.save!
      end
    end
  end
end
