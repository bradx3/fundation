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
