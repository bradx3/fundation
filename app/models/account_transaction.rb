class AccountTransaction < ActiveRecord::Base
  belongs_to :transaction
  belongs_to :account

  include DollarMethods

  named_scope :used, :conditions => [ "amount_in_cents <> 0" ]
end
