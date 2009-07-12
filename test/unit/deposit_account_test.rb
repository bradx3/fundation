require 'test_helper'

class DepositAccountTest < ActiveSupport::TestCase
  should_belong_to :deposit
  should_belong_to :account

  should "convert dollars to cents" do
    d = DepositAccount.new
    d.dollars = 1
    assert_equal 100, d.amount_in_cents

    d.dollars = 2.5
    assert_equal 250, d.amount_in_cents
  end

  should "convert cents to dollars" do
    d = DepositAccount.new

    d.amount_in_cents = 100
    assert_equal 1, d.dollars

    d.amount_in_cents = 356
    assert_equal 3.56, d.dollars
  end
end
