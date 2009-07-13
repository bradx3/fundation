require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_have_many :account_transactions

  should "return initial plus any deposits for balance" do
    account = Factory(:account, :initial_balance_in_cents => 3)
    account.account_transactions.clear
    assert_equal 0.03, account.balance

    account.account_transactions.build(:amount_in_cents => 550)
    assert_equal 5.53, account.balance
  end
end
