class Transaction < ActiveRecord::Base
  has_many :account_transactions
  accepts_nested_attributes_for :account_transactions
  belongs_to :user
  
  include DollarMethods

  def allocated_dollars
    account_transactions.inject(0) { |total, da| total += da.dollars }    
  end

  def init_all_deposit_accounts
    accounts = Account.all
    ats = self.account_transactions
    set_accounts = ats.map { |d| d.account }

    (accounts - set_accounts).each do |acc|
      ats.build(:percentage => 0, :account => acc)
    end
  end
end
