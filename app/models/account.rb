class Account < ActiveRecord::Base
  validates_presence_of :name
  include DollarMethods

  def self.total_balance
    Account.all.inject(0) { |total, acc| total += acc.balance }
  end

  # Returns the balance of this account in dollars
  def balance
    return 0
  end


end
