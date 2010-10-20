require 'test_helper'

class FundTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should have_many :fund_transactions

  should belong_to :user
  should validate_presence_of :user

  should "return initial plus any deposits for balance" do
    fund = Factory(:fund, :initial_balance_in_cents => 3)
    fund.fund_transactions.clear
    assert_equal 0.03, fund.balance

    fund.fund_transactions.build(:amount_in_cents => 550)
    assert_equal 5.53, fund.balance
  end

  should "return name for to_s" do
    f = Factory(:fund)
    assert_equal f.name, f.to_s
  end

  should "unset any existing default sync funds if set" do
    user = Factory(:user)
    f1 = Factory(:fund, :user => user)
    f2 = Factory(:fund, :user => user)

    f1.default_synchronize_fund = true
    f1.save!
    f1.unset_any_other_default_sync_funds

    f2.reload
    assert f1.default_synchronize_fund?
    assert !f2.default_synchronize_fund?

    f2.default_synchronize_fund = true
    f2.save!
    f2.unset_any_other_default_sync_funds

    f1.reload
    assert !f1.default_synchronize_fund?
    assert f2.default_synchronize_fund?
  end
end
