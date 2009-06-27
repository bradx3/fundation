require 'test_helper'

class DepositTypeAccountTest < ActiveSupport::TestCase
  should_belong_to :deposit_type
  should_belong_to :account
end
