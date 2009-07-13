require 'test_helper'

class DepositTypePercentagesTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      integration_login

      @acc1 = Factory.create(:account)
      @acc2 = Factory.create(:account)
      @deposit_type = Factory.create(:deposit_type)
    end

    should "be able to edit deposit types" do
      visit deposit_types_path
      click_link "Show"
      click_link "Edit"

      fill_in "Name", :with => "new name"
      fill_in @acc1.name, :with => "25"
      fill_in @acc2.name, :with => "75"

      click_button "Update"

      @deposit_type.reload
      assert_equal "new name", @deposit_type.name
      assert_equal 25, @deposit_type.deposit_type_account_percentages.first.percentage
      assert_equal 75, @deposit_type.deposit_type_account_percentages[1].percentage
    end

    should "be able to create deposit types" do
      visit deposit_types_path
      click_link "create new deposit type"

      fill_in "Name", :with => "new name"
      fill_in @acc1.name, :with => "50"
      fill_in @acc2.name, :with => "50"

      click_button "Create"

      @deposit_type = assigns["deposit_type"]
      @deposit_type.reload

      assert_equal "new name", @deposit_type.name
      assert_equal 50, @deposit_type.deposit_type_account_percentages.first.percentage
      assert_equal 50, @deposit_type.deposit_type_account_percentages[1].percentage
    end
  end
end
