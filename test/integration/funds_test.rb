require 'test_helper'

class FundsTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      integration_login
    end

    should "be able to create a fund" do
      count = Fund.count
      visit funds_path

      click_link "create new fund"
      fill_in "name", :with => "a new fund"
      click_button "create"

      assert_equal count + 1, Fund.count
    end

  end
end
