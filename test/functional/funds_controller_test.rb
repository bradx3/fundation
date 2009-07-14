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
      fund = Factory.create(:fund)
      get :show, :id => fund.to_param
      assert_response :success
    end

    should "get edit" do
      fund = Factory.create(:fund)
      get :edit, :id => fund.to_param
      assert_response :success
    end

    should "update fund" do
      fund = Factory.create(:fund)
      put :update, :id => fund.to_param, :fund => { }
      assert_redirected_to fund_path(assigns(:fund))
    end

    should "destroy fund" do
      fund = Factory.create(:fund)

      assert_difference('Fund.count', -1) do
        delete :destroy, :id => fund.to_param
      end

      assert_redirected_to funds_path
    end

  end
end
