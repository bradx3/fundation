class Deposit < ActiveRecord::Base
  has_many :deposit_accounts
  accepts_nested_attributes_for :deposit_accounts
  
  include DollarMethods
end
