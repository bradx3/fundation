require 'test_helper'

class SynchronizeTest < ActionController::IntegrationTest

  context "a normal user" do
    setup do
      integration_login
      @acc1 = Factory(:fund, :default_synchronize_fund => true, :user => @user)
      @acc2 = Factory(:fund, :user => @user, :dollars => 20)
      @balance = @user.family.total_balance
    end

    should "be able to synchronize funds" do
      synchronize(@balance - 10)
      transaction = Transaction.last
      assert_equal -10, transaction.dollars
      assert_equal "Synchronize", transaction.description
    end

    should "be able to synchronize to higher balances" do
      synchronize(@balance + 15)
      transaction = Transaction.last
      assert_equal 15, transaction.dollars
      assert_equal "Synchronize", transaction.description
    end
  end

end
