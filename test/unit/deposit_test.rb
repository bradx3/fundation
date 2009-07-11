require 'test_helper'

class DepositTest < ActiveSupport::TestCase
  should_have_many :deposit_accounts
end
