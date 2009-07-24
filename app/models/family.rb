class Family < ActiveRecord::Base
  has_many :users
  has_many :funds, :through => :users, :order => "name"
  has_many :deposit_templates, :through => :users
  has_many :transactions, :through => :users

  def total_balance
    funds.inject(0) { |total, acc| total += acc.balance }
  end

  def synchronize_fund
    @sync_fund ||= funds.detect { |f| f.default_synchronize_fund? }
  end

end
