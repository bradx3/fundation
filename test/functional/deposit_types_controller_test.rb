require 'test_helper'

class DepositTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deposit_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deposit_type" do
    assert_difference('DepositType.count') do
      post :create, :deposit_type => Factory.build(:deposit_type).attributes
    end

    assert_redirected_to deposit_type_path(assigns(:deposit_type))
  end

  test "should show deposit_type" do
    deposit_type = Factory.create(:deposit_type)
    get :show, :id => deposit_type.to_param
    assert_response :success
  end

  test "should get edit" do
    deposit_type = Factory.create(:deposit_type)
    get :edit, :id => deposit_type.to_param
    assert_response :success
  end

  test "should update deposit_type" do
    deposit_type = Factory.create(:deposit_type)
    put :update, :id => deposit_type.to_param, :deposit_type => { }
    assert_redirected_to deposit_type_path(assigns(:deposit_type))
  end

  test "should destroy deposit_type" do
    deposit_type = Factory.create(:deposit_type)

    assert_difference('DepositType.count', -1) do
      delete :destroy, :id => deposit_type.to_param
    end

    assert_redirected_to deposit_types_path
  end
end
