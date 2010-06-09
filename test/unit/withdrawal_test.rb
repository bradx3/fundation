require 'test_helper'

class WithdrawalTest < ActiveSupport::TestCase
  context "a normal withdrawal" do

    setup do
      @acc1 = Factory(:fund)
      @withdrawal = Factory(:withdrawal)
    end

    should "update fund_transactions after_save" do
      w = Factory.build(:withdrawal)
      w.fund_transactions.clear

      w.fund_transactions.build(:fund => @acc1, :dollars => 44)
      assert w.save!

      w.reload
      assert_equal -44, w.fund_transactions.first.dollars
    end

    should "update amount_in_cents from fund_transactions before save" do
      w = Factory.build(:withdrawal)
      w.fund_transactions.clear

      w.fund_transactions.build(:fund => @acc1, :dollars => 44)
      assert w.save!

      assert_equal -4400, w.amount_in_cents
    end

    should "return false for synchronize?" do
      assert !@withdrawal.synchronize?
    end
  end

  context "a synchronize withdrawal" do
    setup do
      @acc1 = Factory(:fund)
      @withdrawal = Factory.build(:withdrawal, :description => Transaction::SYNCHRONIZE)
      @withdrawal.fund_transactions.clear
    end

    should "return true for synchronize?" do
      assert @withdrawal.synchronize?
    end

    should "not update amount_in_cents from fund_transactions before save" do
      @withdrawal.dollars = -44

      @withdrawal.fund_transactions.build(:fund => @acc1, :dollars => 44)
      assert @withdrawal.save!
      assert_equal -4400, @withdrawal.amount_in_cents
    end
  end
end
