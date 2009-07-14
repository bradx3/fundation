require 'test_helper'

class WithdrawalTest < ActiveSupport::TestCase
  setup do
    @acc1 = Factory(:fund)
  end

  should "update fund_transactions after_save" do
    w = Withdrawal.new
    w.fund_transactions.build(:fund => @acc1, :dollars => 44)
    assert w.save!

    w.reload
    assert_equal -44, w.fund_transactions.first.dollars
  end

  should "update amount_in_cents from fund_transactions before save" do
    w = Withdrawal.new

    w.fund_transactions.build(:fund => @acc1, :dollars => 44)
    assert w.save!

    assert_equal -4400, w.amount_in_cents
  end
end
