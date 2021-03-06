require 'test_helper'

class DepositTemplatesControllerTest < ActionController::TestCase
  should_require_user_for_all_methods
  should_keep_it_in_the_family(:deposit_template)

  context "a logged in user" do
    setup do
      login
    end

    should "get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:deposit_templates)
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create deposit_template" do
      assert_difference('DepositTemplate.count') do
        post :create, :deposit_template => Factory.build(:deposit_template).attributes
      end

      assert_redirected_to deposit_template_path(assigns(:deposit_template))
    end

    should "show deposit_template" do
      deposit_template = Factory.create(:deposit_template, :user => @user)
      get :show, :id => deposit_template.to_param
      assert_response :success
    end

    should "get edit" do
      deposit_template = Factory.create(:deposit_template, :user => @user)
      get :edit, :id => deposit_template.to_param
      assert_response :success
    end

    should "update deposit_template" do
      deposit_template = Factory.create(:deposit_template, :user => @user)
      put :update, :id => deposit_template.to_param, :deposit_template => { }
      assert_redirected_to deposit_template_path(assigns(:deposit_template))
    end

    should "destroy deposit_template" do
      deposit_template = Factory.create(:deposit_template, :user => @user)

      assert_difference('DepositTemplate.count', -1) do
        delete :destroy, :id => deposit_template.to_param
      end

      assert_redirected_to deposit_templates_path
    end
  end

end
