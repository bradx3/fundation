require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  should_validate_presence_of :name

  should "return balance as dollars" do
    account = Account.new

    account.balance_in_cents = 0
    assert_equal 0.00, account.balance

    account.balance_in_cents = 105
    assert_equal 1.05, account.balance

    account.balance_in_cents = -300
    assert_equal -3.00, account.balance
  end
end
