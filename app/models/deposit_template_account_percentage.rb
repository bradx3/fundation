class DepositTemplateAccountPercentage < ActiveRecord::Base
  belongs_to :deposit_template
  belongs_to :account
end
