require 'test_helper'

class DepositTest < ActiveSupport::TestCase
  context "with a few funds" do
    setup do 
      @user = Factory(:user)
      @funds = []
      6.times { @funds << Factory(:fund, :user => @user) }
    end

    should "validate allocations add to total" do
      d = Factory.build(:deposit)
      d.fund_transactions.clear

      d.dollars = 100
      d.fund_transactions.build(:fund => @funds[0], :dollars => 5)
      d.fund_transactions.build(:fund => @funds[1], :dollars => 10)
      assert !d.valid?
      assert d.errors[:base].any?

      d.fund_transactions.first.dollars = 90
      assert d.valid?
    end

    should "validate amount is greater than zero" do
      d = Factory.build(:deposit)
      d.dollars = 0
      assert !d.valid?
      assert d.errors[:base].any?
    end

    should "handle allocations with fractions of cents" do
      d = Factory.build(:deposit)
      d.fund_transactions.clear

      d.dollars = 3333.21

      amounts = [ 999.97, 999.96, 1166.62, 100.00, 33.33, 33.33 ]
      amounts.each_with_index do |amt, i|
        d.fund_transactions.build(:fund => @funds[i], :dollars => amt)
      end

      assert d.valid?
    end

    should "handle allocations that didn't work on 20/08/09" do
      d = Factory.build(:deposit)
      d.fund_transactions.clear

      d.dollars = 149.23

      amounts = [ 0, 0, 0, 0, 149.23, 0, 0, 0 ]
      amounts.each_with_index do |amt, i|
        d.fund_transactions.build(:fund => @funds[i], :dollars => amt)
      end

      assert d.valid?
    end
  end
end
