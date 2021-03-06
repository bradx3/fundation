require 'test_helper'

class DepositIntegrationTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      integration_login

      @acc1 = Factory.create(:fund, :user => @user)
      @acc2 = Factory.create(:fund, :user => @user)
    end

    should "be able to create a deposit" do
      count = Deposit.count

      visit new_deposit_path
      amount = 4321.to_f
      fill_in "Amount", :with => amount
      fill_in "Description", :with => "a test deposit"
      fill_in "deposit[fund_transactions_attributes][0][dollars]", :with => (amount * 0.66)
      fill_in "deposit[fund_transactions_attributes][1][dollars]", :with => (amount * 0.34)
      click_button "Create"

      assert_equal count + 1, Deposit.count
      deposit = Deposit.last
      assert_equal 4321, deposit.dollars
      assert_equal UserSession.find.user, deposit.user
    end

    should "be able to delete a deposit" do
      deposit = Factory(:deposit, :user => @user)
      count = Deposit.count

      visit deposit_path(deposit)
      click_link "Delete This Deposit"

      assert_equal count - 1, Deposit.count
    end

  end
end
