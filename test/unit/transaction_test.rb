require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  should_have_many :fund_transactions, :dependent => :destroy
  should_belong_to :user

  should "convert dollars to cents" do
    d = Transaction.new
    d.dollars = 1
    assert_equal 100, d.amount_in_cents

    d.dollars = 2.5
    assert_equal 250, d.amount_in_cents
  end

  should "convert cents to dollars" do
    d = Transaction.new

    d.amount_in_cents = 100
    assert_equal 1, d.dollars

    d.amount_in_cents = 356
    assert_equal 3.56, d.dollars
  end

  should "remove unused fund_transactions before save" do
    t = Transaction.new
    t.fund_transactions.clear
    t.fund_transactions.build

    assert t.fund_transactions.any?
    t.save(false) # don't need validations here, just the callback
    assert t.fund_transactions.empty?
  end
end
