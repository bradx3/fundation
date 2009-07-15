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

    should "be able to create a new user" do
      count = @user.family.users.count

      visit users_path
      click_link "create a new user"

      fill_in "email", :with => "newuser@email.com"
      click_button "create"

      assert_sent_email
      new_user = User.last
      assert_equal count + 1, @user.family.users.count

      UserSession.find.destroy

      visit confirm_users_path(:token => new_user.perishable_token)
      fill_in "login", :with => "my new login"
      fill_in "password", :with => "my new password"
      fill_in "password confirmation", :with => "my new password"

      click_button "confirm"

      user = UserSession.find.user
      assert_equal "my new login", user.login
      assert user.valid_password?("my new password")
    end
  end
end
