require 'test_helper'

class RegistrationControllerTest < ActionController::TestCase
  should "get index" do
    get :index
    assert_response :success
  end

  context "a logged in user" do
    setup do
      login
    end
    
    should "get step2" do
      get :step2
      assert_response :success
    end

    should "get step3" do
      get :step2
      assert_response :success
    end

    should "get step4" do
      get :step2
      assert_response :success
    end

    context "with some funds already setup" do
      setup do
        2.times { Factory(:fund, :user => @user) }
        assert @user.funds.any?
      end

      should "clear funds in step2" do
        get :step2
        assert @user.reload.funds.empty?
      end

      should "clear funds in setup_funds" do
        post :setup_funds, :user => {}
        assert @user.reload.funds.empty?
      end
    end

    context "with some deposit templates already setup" do
      setup do
        2.times { Factory(:deposit_template, :user => @user) }
        assert @user.deposit_templates.any?
      end

      should "clear funds in step2" do
        get :step2
        assert @user.reload.deposit_templates.empty?
      end

      should "clear funds in setup_funds" do
        post :setup_funds, :user => {}
        assert @user.reload.deposit_templates.empty?
      end
    end
  end
end
