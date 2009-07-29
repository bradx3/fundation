require 'test_helper'

class RegistrationTest < ActionController::IntegrationTest
  should "be able to register a new user and setup account" do
    visit "/"
    click_link "Sign Up"
    
    fill_in "login", :with => "test_login"
    fill_in "email", :with => "atest@email.com"
    fill_in "password", :with => "password"
    fill_in "password confirmation", :with => "password"

    click_button "Sign Up"
    user = UserSession.find.user
    assert_not_nil user

    fill_in "user_funds_attributes_0_name", :with => "Fund1"
    fill_in "user_funds_attributes_0_dollars", :with => "50"

    click_button "Continue"
    user.reload
    assert_equal "Fund1", user.family.funds[1].name
    assert_equal 50, user.family.funds[1].dollars
    
    assert_equal "Not", "Done"
  end
end
