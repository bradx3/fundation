require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  should have_many :fund_transactions
  should belong_to :user

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
    t.save(:validate => false) # don't need validations here, just the callback
    assert t.fund_transactions.empty?
  end

  should "only use active funds when init_all_deposit_funds" do
    user = Factory(:user)
    archived = Factory(:fund, :archived => true, :user => user)
    normal = Factory(:fund, :user => user)
    t = Transaction.new(:user => user)
    t.init_all_deposit_funds
    assert_equal 1, t.fund_transactions.length
    assert_equal normal, t.fund_transactions.first.fund
  end
end
