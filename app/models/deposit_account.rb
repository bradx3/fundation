class DepositAccount < ActiveRecord::Base
  belongs_to :deposit
  belongs_to :account

  include DollarMethods
end
