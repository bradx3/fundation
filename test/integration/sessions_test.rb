require 'test_helper'

class SessionsTest < ActionController::IntegrationTest

  context "with an existing user" do
    setup do
      @user = Factory(:user)
    end

    should "be able to log in" do
      visit "/login"
#      click_link "login"
      fill_in "Login", :with => @user.login
      fill_in "Password", :with => @user.password
      check "Remember me"
      click_button "Login"

      assert_equal @user, UserSession.find.user
    end

    should "be able to log out" do
      integration_login
      click_link "Logout"
      assert_nil UserSession.find
    end

  end

end
