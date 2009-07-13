require 'test_helper'

class SynchronizeTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      integration_login
      @acc1 = Factory(:account, :default_synchronize_fund => true)
      @acc2 = Factory(:account)
    end

    should "be able to synchronize accounts" do
      balance = Account.total_balance
      amount = (balance / 2.0)

      visit accounts_path
      click_link "synchronize with real account"
      fill_in "actual balance", :with => amount
      click_button "synchronize"
      click_button "create"

      transaction = Transaction.last
      assert_equal -amount, transaction.dollars
    end
  end
end
