require 'test_helper'

class FundTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_have_many :fund_transactions

  should_belong_to :user
  should_validate_presence_of :user

  should "return initial plus any deposits for balance" do
    fund = Factory(:fund, :initial_balance_in_cents => 3)
    fund.fund_transactions.clear
    assert_equal 0.03, fund.balance

    fund.fund_transactions.build(:amount_in_cents => 550)
    assert_equal 5.53, fund.balance
  end
end
