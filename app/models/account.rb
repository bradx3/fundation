class Account < ActiveRecord::Base
  validates_presence_of :name

  # Returns the balance of this account in dollars
  def balance
    dollars = (balance_in_cents || 0) / 100.0
    return dollars
  end

end
