require 'test_helper'

class DepositAccountTest < ActiveSupport::TestCase
  should_belong_to :deposit
  should_belong_to :account
end
