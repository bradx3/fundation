require 'test_helper'

class WithdrawalTest < ActiveSupport::TestCase
  setup do
    @acc1 = Factory(:account)
  end

  should "update account_transactions after_save" do
    w = Withdrawal.new
    w.account_transactions.build(:account => @acc1, :dollars => 44)
    assert w.save!

    assert w.dollars = -44
  end
end
