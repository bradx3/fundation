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
