require 'test_helper'

class DepositIntegrationTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      integration_login

      @acc1 = Factory.create(:fund)
      @acc2 = Factory.create(:fund)
    end

    should "be able to create a deposit" do
      count = Deposit.count

      visit new_deposit_path
      fill_in "amount", :with => 1000
      fill_in "deposit[fund_transactions_attributes][0][dollars]", :with => 750
      fill_in "deposit[fund_transactions_attributes][1][dollars]", :with => 250
      click_button "create"

      assert_equal count + 1, Deposit.count
      deposit = assigns(:deposit)
      assert_equal 1000, deposit.dollars
      assert_equal UserSession.find.user, deposit.user
    end

  end
end
