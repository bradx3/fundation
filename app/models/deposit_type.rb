class DepositType < ActiveRecord::Base
  validates_presence_of :name
  has_many :deposit_type_accounts
  validates_uniqueness_of :name
end
