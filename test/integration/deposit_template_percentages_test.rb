require 'test_helper'

class DepositTemplatePercentagesTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      integration_login

      @acc1 = Factory(:fund, :user => @user)
      @acc2 = Factory(:fund, :user => @user)
      @deposit_template = Factory(:deposit_template, :user => @user)
    end

    should "be able to edit deposit types" do
      visit deposit_templates_path
      click_link @deposit_template.name
      click_link "Edit"

      fill_in "Name", :with => "new name"
      fill_in @acc1.name, :with => "25"
      fill_in @acc2.name, :with => "75"

      click_button "Update"

      @deposit_template.reload
      assert_equal "new name", @deposit_template.name
      dtfps = @deposit_template.deposit_template_fund_percentages
      dtfps = dtfps.sort_by { |d| d.percentage }
      assert_equal 25, dtfps[0].percentage
      assert_equal 75, dtfps[1].percentage
    end

    should "be able to create deposit templates" do
      visit deposit_templates_path
      click_link "Create New Deposit Template"

      fill_in "Name", :with => "new name"
      fill_in @acc1.name, :with => "50"
      fill_in @acc2.name, :with => "50"

      click_button "Create"

      @deposit_template = DepositTemplate.last
      @deposit_template.reload

      assert_equal "new name", @deposit_template.name
      assert_equal 50, @deposit_template.deposit_template_fund_percentages.first.percentage
      assert_equal 50, @deposit_template.deposit_template_fund_percentages[1].percentage
    end
  end
end
