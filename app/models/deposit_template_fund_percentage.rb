class DepositTemplateFundPercentage < ActiveRecord::Base
  belongs_to :deposit_template
  belongs_to :fund
end
