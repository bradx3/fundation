require 'test_helper'

class FundTransactionTest < ActiveSupport::TestCase
  should_belong_to :transaction
  should_belong_to :fund

  should "convert dollars to cents" do
    d = FundTransaction.new
    d.dollars = 1
    assert_equal 100, d.amount_in_cents

    d.dollars = 2.5
    assert_equal 250, d.amount_in_cents
  end

  should "convert cents to dollars" do
    d = FundTransaction.new

    d.amount_in_cents = 100
    assert_equal 1, d.dollars

    d.amount_in_cents = 356
    assert_equal 3.56, d.dollars
  end
end
