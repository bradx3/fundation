require 'test_helper'

class DepositsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deposits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deposit" do
    assert_difference('Deposit.count') do
      post :create, :deposit => { }
    end

    assert_redirected_to deposit_path(assigns(:deposit))
  end

  test "should show deposit" do
    get :show, :id => deposits(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => deposits(:one).to_param
    assert_response :success
  end

  test "should update deposit" do
    put :update, :id => deposits(:one).to_param, :deposit => { }
    assert_redirected_to deposit_path(assigns(:deposit))
  end

  test "should destroy deposit" do
    assert_difference('Deposit.count', -1) do
      delete :destroy, :id => deposits(:one).to_param
    end

    assert_redirected_to deposits_path
  end
end
