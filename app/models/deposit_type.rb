class DepositType < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :deposit_type_account_percentages
  accepts_nested_attributes_for :deposit_type_account_percentages
end
