require 'test_helper'

class ForgotPasswordTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      @user = Factory(:user)
      ActionMailer::Base.deliveries.clear
    end
    
    should "be able to get to reset their password" do
      visit "/login"
      click_link "Forgot your password?"

      fill_in "Login or Email", :with => @user.login
      click_button "Reset Password"
      assert_equal ActionMailer::Base.deliveries.length, 1

      token = @user.reload.attributes["perishable_token"]
      visit "/password_resets/edit?id=#{ token }"
      fill_in "Password", :with => "new password"
      fill_in "Password confirmation", :with => "new password"
      click_button "Update my password and log me in"

      assert_not_nil UserSession.find
      assert @user.reload.valid_password?("new password")
    end
  end

end
