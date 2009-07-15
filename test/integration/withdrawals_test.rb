require 'test_helper'

class WithdrawalsTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      integration_login

      @fund1 = Factory.create(:fund, :user => @user)
      @fund2 = Factory.create(:fund, :user => @user)
    end

    should "be able to create a withdrawal" do
      count = Withdrawal.count
      
      visit new_withdrawal_path
      fill_in @fund1.name, :with => 25
      fill_in @fund2.name, :with => 33
      click_button "create"

      assert_equal count + 1, Withdrawal.count
      w = assigns(:withdrawal)
      assert_equal -58, w.dollars
      assert_equal UserSession.find.user, w.user
    end

    should "be able to delete a withdrawal" do
      w = Factory(:withdrawal, :user => @user)
      count = Withdrawal.count

      visit withdrawal_path(w)
      click_link "Delete this withdrawal"

      assert_equal count - 1, Withdrawal.count
    end
  end
end
