class Withdrawal < Transaction
  after_save :ensure_amounts_are_negative

  private

  def ensure_amounts_are_negative
    account_transactions.each do |at|
      if at.dollars > 0
        at.dollars = (0 - at.dollars) 
        at.save!
      end
    end
  end
end
