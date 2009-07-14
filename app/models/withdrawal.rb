class Withdrawal < Transaction
  before_save :update_amount_from_fund_transactions
  after_save :ensure_amounts_are_negative

  private

  def update_amount_from_fund_transactions
    res = 0
    fund_transactions.each do |at|
      res += at.dollars.abs
    end

    self.dollars = (0 - res)
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
