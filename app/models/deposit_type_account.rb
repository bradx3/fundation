class DepositTypeAccount < ActiveRecord::Base
  belongs_to :deposit_type
  belongs_to :account
end
