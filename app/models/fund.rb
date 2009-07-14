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


end
