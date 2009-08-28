require 'test_helper'

class ForgotPasswordTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      @user = Factory(:user)
      ActionMailer::Base.deliveries.clear
    end
    
    should "be able to get to reset their password" do
      visit "/login"
      click_link "forgot your password?"

      fill_in :login, :with => @user.login
      click_button "reset password"
      assert_sent_email

      token = @user.reload.attributes["perishable_token"]
      visit "/password_resets/edit?id=#{ token }"
      fill_in "password", :with => "new password"
      fill_in "password confirmation", :with => "new password"
      click_button "update my password and log me in"

      assert_not_nil UserSession.find
      assert @user.reload.valid_password?("new password")
    end
  end

end
