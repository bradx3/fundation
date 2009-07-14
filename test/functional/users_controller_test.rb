require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  should_require_user_for_all_methods

  context "a logged in user" do
    setup do
      login
    end

    should "get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:users)
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create users" do
      assert_difference('User.count') do
        post :create, :user => Factory.attributes_for(:user)
      end

      assert_redirected_to user_path(assigns(:user))
    end

    should "show user" do
      user = Factory(:user)
      get :show, :id => user.to_param
      assert_response :success
    end

    should "get edit" do
      user = Factory(:user)
      get :edit, :id => user.to_param
      assert_response :success
    end

    should "update user" do
      user = Factory(:user)
      put :update, :id => user.to_param, :user => user.attributes
      assert_redirected_to assigns(:user)
    end

    should "destroy user" do
      user = Factory(:user)
      assert_difference('User.count', -1) do
        delete :destroy, :id => user.to_param
      end

      assert_redirected_to users_path
    end
  end
end
