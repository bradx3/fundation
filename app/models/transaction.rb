class Transaction < ActiveRecord::Base
  has_many :fund_transactions, :dependent => :destroy
  accepts_nested_attributes_for :fund_transactions

  belongs_to :user
  validates_presence_of :user
  
  include DollarMethods

  def allocated_dollars
    cents = fund_transactions.inject(0) { |total, da| total += da.amount_in_cents.to_f }    
    return cents.to_f / 100.00
  end

  def init_all_deposit_funds
    funds = user.family.funds
    fts = self.fund_transactions
    set_funds = fts.map { |d| d.fund }

    (funds - set_funds).each do |f|
      fts.build(:percentage => 0, :fund => f)
    end
  end
end
