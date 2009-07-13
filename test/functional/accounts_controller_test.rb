require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  should_require_user_for_all_methods

  context "with a logged in user" do
    setup do
      login
    end

    should "get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:accounts)
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create account" do
      assert_difference('Account.count') do
        post :create, :account => Factory.build(:account).attributes
      end

      assert_redirected_to account_path(assigns(:account))
    end

    should "show account" do
      account = Factory.create(:account)
      get :show, :id => account.to_param
      assert_response :success
    end

    should "get edit" do
      account = Factory.create(:account)
      get :edit, :id => account.to_param
      assert_response :success
    end

    should "update account" do
      account = Factory.create(:account)
      put :update, :id => account.to_param, :account => { }
      assert_redirected_to account_path(assigns(:account))
    end

    should "destroy account" do
      account = Factory.create(:account)

      assert_difference('Account.count', -1) do
        delete :destroy, :id => account.to_param
      end

      assert_redirected_to accounts_path
    end

  end
end
