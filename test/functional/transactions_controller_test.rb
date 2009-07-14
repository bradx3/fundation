require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  should_require_user_for_all_methods
  should_keep_it_in_the_family(:deposit)

  context "a logged in user" do
    setup do
      login
      # create a couple so things render
      2.times { Factory(:deposit, :user => @user) }
    end

    should "get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:transactions)
    end

    should "destroy transaction" do
      tran = Factory(:deposit, :user => @user)

      assert_difference('Transaction.count', -1) do
        delete :destroy, :id => tran.to_param
      end

      assert_redirected_to transactions_path
    end
  end
end
