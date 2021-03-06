require 'test_helper'

class SynchronizeControllerTest < ActionController::TestCase
  should_require_user_for_all_methods
  
  context "with a logged in user" do
    setup do
      login
      5.times { Factory(:fund, :user => @user) }
      @user.family.funds.reload
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "post start" do
      new_balance = @user.family.total_balance - 1
      assert new_balance > 0
      post :start, :actual_balance => new_balance
      assert_response :success
    end
  end  
end
