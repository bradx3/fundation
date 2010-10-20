require 'test_helper'

class UsersTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      integration_login
      ActionMailer::Base.deliveries.clear
    end

    should "be able to edit user details" do
      visit "/"
      click_link "profile"
      
      fill_in "Login", :with => "a new login"
      fill_in "Email", :with => "new_email@test.com"

      click_button "Update"

      @user.reload
      assert_equal "a new login", @user.login
      assert_equal "new_email@test.com", @user.email
    end

    should "be able to update their password" do
      visit "/"
      click_link "profile"
      
      fill_in "Password", :with => "a new password"
      fill_in "Password confirmation", :with => "a new password"
      click_button "Update"

      @user.reload
      assert @user.valid_password?("a new password")
    end

    should "be able to create a new user" do
      count = @user.family.users.count

      visit users_path
      click_link "Create A New User"

      fill_in "Email", :with => "newuser@email.com"
      click_button "Create"

      assert_equal ActionMailer::Base.deliveries.length, 1
      new_user = User.last
      assert_equal count + 1, @user.family.users.count

      UserSession.find.destroy

      visit confirm_users_path(:token => new_user.perishable_token)
      fill_in "Login", :with => "my new login"
      fill_in "Password", :with => "my new password"
      fill_in "Password confirmation", :with => "my new password"

      click_button "Confirm"

      user = UserSession.find.user
      assert_equal "my new login", user.login
      assert user.valid_password?("my new password")
    end
  end
end
