class Account < ActiveRecord::Base
  validates_presence_of :name
  has_many :account_transactions

  include DollarMethods

  def self.total_balance
    Account.all.inject(0) { |total, acc| total += acc.balance }
  end

  # Returns the balance of this account in dollars
  def balance
    res = dollars

    account_transactions.each do |tran|
      res += tran.dollars
    end

    return res
  end


end
