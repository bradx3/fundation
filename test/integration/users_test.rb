require 'test_helper'

class UsersTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      integration_login
    end

    should "be able to edit user details" do
      visit "/"
      click_link "profile"
      
      fill_in :login, :with => "a new login"
      fill_in :email, :with => "new_email@test.com"

      click_button "update"

      @user.reload
      assert_equal "a new login", @user.login
      assert_equal "new_email@test.com", @user.email
    end

    should "be able to update their password" do
      visit "/"
      click_link "profile"
      
      fill_in "password", :with => "a new password"
      fill_in "password confirmation", :with => "a new password"
      click_button "update"

      @user.reload
      assert @user.valid_password?("a new password")
    end
  end
end
