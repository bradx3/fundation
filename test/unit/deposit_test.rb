require 'test_helper'

class DepositTest < ActiveSupport::TestCase
  context "with a few accounts" do
    setup do 
      @acc1 = Factory.create(:account)
      @acc2 = Factory.create(:account)
    end

    should "validate allocations add to total" do
      d = Deposit.new
      d.dollars = 100
      d.account_transactions.build(:account => @acc1, :dollars => 5)
      d.account_transactions.build(:account => @acc2, :dollars => 10)
      assert !d.valid?
      assert d.errors.on_base

      d.account_transactions.first.dollars = 90
      assert d.valid?
    end

    should "validate amount is greater than zero" do
      d = Deposit.new
      d.dollars = 0
      assert !d.valid?
      assert d.errors.on_base
    end
  end
end
