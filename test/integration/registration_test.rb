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

    fill_in "user_funds_attributes_0_name", :with => "AAAA Fund" # start with aa so gets returned first in lists below
    fill_in "user_funds_attributes_0_dollars", :with => "50"
    click_button "Continue"
    user.reload
    assert_equal "AAAA Fund", user.family.funds[0].name
    assert_equal 50, user.family.funds[0].dollars

    fill_in "aaaa fund", :with => 100
    click_button "continue"
    t = user.reload.deposit_templates.first
    assert_equal 100, t.deposit_template_fund_percentages[0].percentage
    
    click_link "complete"
  end
end
