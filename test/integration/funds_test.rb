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

    should "be able to edit a fund" do
      fund = Factory(:fund, :user => @user)
      visit funds_path

      click_link fund.name
      click_link "edit"

      fill_in "name", :with => "an edited fund"
      check "default synchronize fund"

      click_button "update"

      fund.reload
      assert_equal "an edited fund", fund.name
      assert fund.default_synchronize_fund?
    end

  end
end
