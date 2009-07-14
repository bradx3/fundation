require 'test_helper'

class FundsControllerTest < ActionController::TestCase
  should_require_user_for_all_methods

  context "with a logged in user" do
    setup do
      login
    end

    should "get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:funds)
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create fund" do
      assert_difference('Fund.count') do
        post :create, :fund => Factory.build(:fund).attributes
      end

      assert_redirected_to fund_path(assigns(:fund))
    end

    should "show fund" do
      fund = Factory.create(:fund, :user => @user)
      get :show, :id => fund.to_param
      assert_response :success
    end

    should "get edit" do
      fund = Factory.create(:fund, :user => @user)
      get :edit, :id => fund.to_param
      assert_response :success
    end

    should "update fund" do
      fund = Factory.create(:fund, :user => @user)
      put :update, :id => fund.to_param, :fund => { }
      assert_redirected_to fund_path(assigns(:fund))
    end

    should "destroy fund" do
      fund = Factory.create(:fund, :user => @user)

      assert_difference('Fund.count', -1) do
        delete :destroy, :id => fund.to_param
      end

      assert_redirected_to funds_path
    end

  end

 context "a user trying to access users from other families" do
    setup do
      login
      
      @other = Factory(:fund)
      assert @user.family != @other.user.family
    end

    should "not be able to show" do
      assert_raise ActiveRecord::RecordNotFound do
        get :show, :id => @other.id
      end
    end

    should "not be able to edit" do
      assert_raise ActiveRecord::RecordNotFound do
        get :edit, :id => @other.id
      end
    end

    should "not be able to update" do
      assert_raise ActiveRecord::RecordNotFound do
        put :update, :id => @other.id
      end
    end

    should "not be able to delete" do
      assert_raise ActiveRecord::RecordNotFound do
        delete :destroy, :id => @other.id
      end
    end
  end
end
