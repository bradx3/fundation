require 'test_helper'

class DepositTemplatetest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      integration_login

      @acc1 = Factory.create(:fund, :user => @user, :name => "fund1")
      @acc2 = Factory.create(:fund, :user => @user, :name => "fund2")
    end

    should "be able to create a deposit template" do
      count = DepositTemplate.count

      visit new_deposit_template_path
      fill_in "Name", :with => "test template"
      fill_in "fund1", :with => 25
      fill_in "fund2", :with => 75
      click_button "Create"

      assert_equal count + 1, DepositTemplate.count
      dt = DepositTemplate.last
      assert_equal 25, dt.deposit_template_fund_percentages[0].percentage
      assert_equal @acc1, dt.deposit_template_fund_percentages[0].fund
      assert_equal 75, dt.deposit_template_fund_percentages[1].percentage
      assert_equal @acc2, dt.deposit_template_fund_percentages[1].fund
    end

    should "be able to delete a deposit template" do
      dt = Factory(:deposit_template, :user => @user)
      count = DepositTemplate.count

      visit deposit_template_path(dt)
      click_link "Delete This Template"

      assert_equal count - 1, DepositTemplate.count
    end

  end
end
