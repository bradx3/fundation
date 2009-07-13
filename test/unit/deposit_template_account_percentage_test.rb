require 'test_helper'

class DepositTemplateAccountPercentageTest < ActiveSupport::TestCase
  should_belong_to :deposit_template
  should_belong_to :account
end
