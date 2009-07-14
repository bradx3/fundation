require 'test_helper'

class SynchronizeControllerTest < ActionController::TestCase
  should_require_user_for_all_methods
  
  context "with a logged in user" do
    setup do
      login
      @acc1 = Factory(:fund)
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "redirect from create" do
      
      post :create, :actual_balance => 10
      assert_template "withdrawals/new"
      assert_response :success
    end
  end  
end
