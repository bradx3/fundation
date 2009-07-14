require 'test_helper'

class DepositTest < ActiveSupport::TestCase
  context "with a few funds" do
    setup do 
      @acc1 = Factory.create(:fund)
      @acc2 = Factory.create(:fund)
    end

    should "validate allocations add to total" do
      d = Factory.build(:deposit)
      d.fund_transactions.clear

      d.dollars = 100
      d.fund_transactions.build(:fund => @acc1, :dollars => 5)
      d.fund_transactions.build(:fund => @acc2, :dollars => 10)
      assert !d.valid?
      assert d.errors.on_base

      d.fund_transactions.first.dollars = 90
      assert d.valid?
    end

    should "validate amount is greater than zero" do
      d = Factory.build(:deposit)
      d.dollars = 0
      assert !d.valid?
      assert d.errors.on_base
    end
  end
end
