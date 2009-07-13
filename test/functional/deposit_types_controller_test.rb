require 'test_helper'

class DepositTypesControllerTest < ActionController::TestCase
  should_require_user_for_all_methods

  context "a logged in user" do
    setup do
      login
    end

    should "get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:deposit_types)
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create deposit_type" do
      assert_difference('DepositType.count') do
        post :create, :deposit_type => Factory.build(:deposit_type).attributes
      end

      assert_redirected_to deposit_type_path(assigns(:deposit_type))
    end

    should "show deposit_type" do
      deposit_type = Factory.create(:deposit_type)
      get :show, :id => deposit_type.to_param
      assert_response :success
    end

    should "get edit" do
      deposit_type = Factory.create(:deposit_type)
      get :edit, :id => deposit_type.to_param
      assert_response :success
    end

    should "update deposit_type" do
      deposit_type = Factory.create(:deposit_type)
      put :update, :id => deposit_type.to_param, :deposit_type => { }
      assert_redirected_to deposit_type_path(assigns(:deposit_type))
    end

    should "destroy deposit_type" do
      deposit_type = Factory.create(:deposit_type)

      assert_difference('DepositType.count', -1) do
        delete :destroy, :id => deposit_type.to_param
      end

      assert_redirected_to deposit_types_path
    end
  end
end
