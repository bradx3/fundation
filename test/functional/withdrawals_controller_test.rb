require 'test_helper'

class WithdrawalsControllerTest < ActionController::TestCase
  should_require_user_for_all_methods
  should_keep_it_in_the_family(:withdrawal)

  context "with a logged in user" do
    setup do
      login
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create withdrawal" do
      assert_difference('Withdrawal.count') do
        post :create, :withdrawal => { }
      end

      assert_redirected_to withdrawal_path(assigns(:withdrawal))
    end

  end
end
