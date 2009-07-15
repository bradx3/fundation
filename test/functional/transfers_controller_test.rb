require 'test_helper'

class TransfersControllerTest < ActionController::TestCase
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

    should "redirect from create" do
      post(:create, :amount => 100,
           :from => @user.family.funds.first, :to => @user.family.funds.last)
      assert_redirected_to "/transactions"
    end
  end

end
