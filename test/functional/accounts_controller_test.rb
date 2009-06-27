require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account" do
    assert_difference('Account.count') do
      post :create, :account => Factory.build(:account).attributes
    end

    assert_redirected_to account_path(assigns(:account))
  end

  test "should show account" do
    account = Factory.create(:account)
    get :show, :id => account.to_param
    assert_response :success
  end

  test "should get edit" do
    account = Factory.create(:account)
    get :edit, :id => account.to_param
    assert_response :success
  end

  test "should update account" do
    account = Factory.create(:account)
    put :update, :id => account.to_param, :account => { }
    assert_redirected_to account_path(assigns(:account))
  end

  test "should destroy account" do
    account = Factory.create(:account)

    assert_difference('Account.count', -1) do
      delete :destroy, :id => account.to_param
    end

    assert_redirected_to accounts_path
  end
end
