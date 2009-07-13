class Account < ActiveRecord::Base
  validates_presence_of :name
  has_many :deposit_accounts

  include DollarMethods

  def self.total_balance
    Account.all.inject(0) { |total, acc| total += acc.balance }
  end

  # Returns the balance of this account in dollars
  def balance
    res = dollars

    deposit_accounts.each do |dep|
      res += dep.dollars
    end

    return res
  end


end
