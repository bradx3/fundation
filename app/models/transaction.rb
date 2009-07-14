class Transaction < ActiveRecord::Base
  has_many :fund_transactions, :dependent => :destroy
  accepts_nested_attributes_for :fund_transactions
  belongs_to :user
  
  include DollarMethods

  def allocated_dollars
    fund_transactions.inject(0) { |total, da| total += da.dollars }    
  end

  def init_all_deposit_funds
    funds = Fund.all
    fts = self.fund_transactions
    set_funds = fts.map { |d| d.fund }

    (funds - set_funds).each do |f|
      fts.build(:percentage => 0, :fund => f)
    end
  end
end
