class Fund < ActiveRecord::Base
  validates_presence_of :name
  has_many :fund_transactions

  include DollarMethods

  def self.total_balance
    Fund.all.inject(0) { |total, acc| total += acc.balance }
  end

  # Returns the balance of this fund in dollars
  def balance
    res = dollars

    fund_transactions.each do |tran|
      res += tran.dollars
    end

    return res
  end


end
