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
      fill_in "amount", :with => amount
      fill_in "deposit[fund_transactions_attributes][0][dollars]", :with => (amount * 0.66)
      fill_in "deposit[fund_transactions_attributes][1][dollars]", :with => (amount * 0.34)
      click_button "create"
      assigns(:deposit).errors.each { |e| puts e }

      assert_equal count + 1, Deposit.count
      deposit = assigns(:deposit)
      assert_equal 4321, deposit.dollars
      assert_equal UserSession.find.user, deposit.user
    end

  end
end
