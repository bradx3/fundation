class Fund < ActiveRecord::Base
  validates_presence_of :name
  has_many :fund_transactions
  
  belongs_to :user
  validates_presence_of :user

  include DollarMethods

  # Returns the balance of this fund in dollars
  def balance
    res = dollars

    fund_transactions.each do |tran|
      res += tran.dollars
    end

    return res
  end

  def to_s
    name
  end

  # Returns a list of recent transactions involving this fund
  def recent_transactions
    fts = self.fund_transactions.all(:order => "created_at desc", :limit => 5)
    transactions = fts.map { |ft| ft.transaction }

    return Transaction.trim_filtered_funds(transactions, [ id.to_s ])
  end

  def unset_any_other_default_sync_funds
    funds = user.family.funds - [ self ]
    user.family.funds.each do |f|
      next if f == self

      if f.default_synchronize_fund?
        f.update_attributes(:default_synchronize_fund => false)
      end
    end
  end

end
