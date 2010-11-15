require 'test_helper'

class ViewFundTransactionsTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      integration_login
      @acc1 = Factory.create(:fund, :user => @user)
      @acc2 = Factory.create(:fund, :user => @user)
      Factory.create(:deposit, :dollars => 111, 
                     :user => @user,
                     :fund_transactions => [ Factory.create(:fund_transaction, :fund => @acc1, :dollars => 111) ])
      Factory.create(:deposit, :dollars => 222, 
                     :user => @user,
                     :fund_transactions => [ Factory.create(:fund_transaction, :fund => @acc2, :dollars => 222) ])
      Factory.create(:withdrawal, :dollars => 333, 
                     :user => @user,
                     :fund_transactions => [ Factory.create(:fund_transaction, :fund => @acc1, :dollars => 333) ])
    end

    should "be able to view transactions in a fund" do
      visit funds_path
      click_link @acc1.name
      click_link "Show more transactions"
      assert_not_nil body.index("$111.00")
      assert_not_nil body.index("$-333.00")
      assert_nil body.index("$222.00")
    end
  end
end
