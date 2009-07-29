require 'test_helper'

class TransfersTest < ActionController::IntegrationTest
  context "a normal user" do
    setup do
      integration_login
      @fund1 = Factory(:fund, :default_synchronize_fund => true, :user => @user)
      @fund2 = Factory(:fund, :user => @user)
    end

    should "be able to transfer funds" do
      original_balance = @user.family.total_balance
      amount = (@fund1.dollars / 2.0).round(2)
      assert amount > 0

      visit "/"
      click_link "transfer money"
      fill_in "amount", :with => amount
      select @fund1.name, :from => "from"
      select @fund2.name, :from => "to"
      click_button "transfer"

      deposit, withdrawal = Transaction.all(:order => "id desc", :limit => 2)
      assert_equal (0 - amount), withdrawal.dollars
      assert_equal @fund1, withdrawal.fund_transactions.first.fund

      assert_equal amount, deposit.dollars
      assert_equal @fund2, deposit.fund_transactions.first.fund

      @user.family.reload
      assert_equal original_balance.to_i, @user.family.total_balance.to_i
    end
  end
end
