require 'test_helper'

class FundsControllerTest < ActionController::TestCase
  should_require_user_for_all_methods
  should_keep_it_in_the_family(:fund)

  context "without a logged in user" do
    should "render home/index" do
      get :index
      assert_template "home/index"
    end
  end

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

    context "and some funds" do
      setup do
        @active = Factory(:fund, :user => @user)
        @archived = Factory(:fund, :archived => true, :user => @user)
      end

      should "only show active funds" do
        get :index
        assert_not_nil assigns(:funds)
        assert_equal 1, assigns(:funds).length
        assert_equal @active, assigns(:funds).first
      end
    end

  end

end
