require 'test_helper'

class DepositsControllerTest < ActionController::TestCase
  should_require_user_for_all_methods

  context "a logged in user" do
    setup do
      login
    end

    should "get index" do
      # create  couple so everythings gets rendered
      2.times { Factory.create(:deposit) }

      get :index
      assert_response :success
      assert_not_nil assigns(:deposits)
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "show deposit" do
      get :show, :id => Factory(:deposit).to_param
      assert_response :success
    end

    should "get edit" do
      get :edit, :id => Factory(:deposit).to_param
      assert_response :success
    end

    should "update deposit" do
      deposit = Factory(:deposit)
      put :update, :id => deposit.to_param, :deposit => deposit.attributes
      assert_redirected_to deposit_path(assigns(:deposit))
    end

    should "destroy deposit" do
      Factory(:deposit)

      assert_difference('Deposit.count', -1) do
        delete :destroy, :id => Deposit.first.to_param
      end

      assert_redirected_to deposits_path
    end

    context "render for accounts" do
      setup do
        @acc1 = Factory.create(:account)
        @acc2 = Factory.create(:account)
        @type = Factory.create(:deposit_type)
        @type.deposit_type_account_percentages.build(:account => @acc1, :percentage => 25).save!
        @type.deposit_type_account_percentages.build(:account => @acc2, :percentage => 75).save!
      end
      
      should "return values with amount empty" do
        get :accounts, :type_id => @type.id
        result = assigns["result"]

        assert_equal 0, result[@acc1.id][:amount]
        assert_equal 25, result[@acc1.id][:percentage]
        assert_equal 0, result[@acc2.id][:amount]
        assert_equal 75, result[@acc2.id][:percentage]
      end

      should "return values with amount non empty" do
        get :accounts, :type_id => @type.id, :amount => 100
        result = assigns["result"]

        assert_equal 25, result[@acc1.id][:amount]
        assert_equal 75, result[@acc2.id][:amount]
      end
    end
  end
end
