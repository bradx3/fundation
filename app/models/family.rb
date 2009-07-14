class Family < ActiveRecord::Base
  has_many :users
  has_many :funds, :through => :users

  def total_balance
    funds.inject(0) { |total, acc| total += acc.balance }
  end

end
