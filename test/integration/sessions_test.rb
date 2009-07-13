require 'test_helper'

class SessionsTest < ActionController::IntegrationTest

  context "with an existing user" do
    setup do
      @user = Factory(:user)
    end

    should "be able to log in" do
      get "/"

      click_link "login"
      fill_in "login", :with => @user.login
      fill_in "password", :with => @user.password
      check "remember me"
      click_button "Login"

      assert_equal @user, UserSession.find.user
    end

    should "be able to log out" do
      login
      click_link "logout"
      assert_nil UserSession.find
    end

  end

end
