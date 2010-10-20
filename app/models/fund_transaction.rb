class FundTransaction < ActiveRecord::Base
  belongs_to :transaction
  belongs_to :fund

  include DollarMethods

  scope :used, :conditions => [ "amount_in_cents <> 0" ]
end
