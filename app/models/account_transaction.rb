class AccountTransaction < ActiveRecord::Base
  belongs_to :transaction
  belongs_to :account

  include DollarMethods
end
