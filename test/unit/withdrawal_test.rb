require 'test_helper'

class WithdrawalTest < ActiveSupport::TestCase
  setup do
    @acc1 = Factory(:account)
  end

  should "update account_transactions after_save" do
    w = Withdrawal.new
    w.account_transactions.build(:account => @acc1, :dollars => 44)
    assert w.save!

    w.reload
    assert_equal -44, w.account_transactions.first.dollars
  end

  should "update amount_in_cents from account_transactions before save" do
    w = Withdrawal.new

    w.account_transactions.build(:account => @acc1, :dollars => 44)
    assert w.save!

    assert_equal -4400, w.amount_in_cents
  end
end
