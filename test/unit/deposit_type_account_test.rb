require 'test_helper'

class DepositTypeAccountPercentageTest < ActiveSupport::TestCase
  should_belong_to :deposit_type
  should_belong_to :account
end
