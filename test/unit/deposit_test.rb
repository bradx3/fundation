require 'test_helper'

class DepositTest < ActiveSupport::TestCase
  should_have_many :deposit_accounts

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
end
