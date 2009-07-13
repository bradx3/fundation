require 'test_helper'

class DepositTest < ActiveSupport::TestCase
  should_have_many :account_transactions, :dependent => :destroy
  should_belong_to :user

  should "convert dollars to cents" do
    d = Deposit.new
    d.dollars = 1
    assert_equal 100, d.amount_in_cents

    d.dollars = 2.5
    assert_equal 250, d.amount_in_cents
  end

  should "convert cents to dollars" do
    d = Deposit.new

    d.amount_in_cents = 100
    assert_equal 1, d.dollars

    d.amount_in_cents = 356
    assert_equal 3.56, d.dollars
  end

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
