require 'test_helper'

class SynchronizeTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      integration_login
      @acc1 = Factory(:fund, :default_synchronize_fund => true, :user => @user)
      @acc2 = Factory(:fund, :user => @user)
    end

    should "be able to synchronize funds" do
      balance = @user.family.total_balance
      amount = (balance - 10)

      visit funds_path
      click_link "synchronize with real fund"
      fill_in "actual balance", :with => amount
      click_button "synchronize"
      click_button "create"

      transaction = Transaction.last
      assert_equal -10, transaction.dollars
      assert_equal "Synchronize", transaction.description
    end
  end
end
