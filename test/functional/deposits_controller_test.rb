require 'test_helper'

class DepositsControllerTest < ActionController::TestCase
  should_require_user_for_all_methods
  should_keep_it_in_the_family(:deposit)

  context "a logged in user" do
    setup do
      login
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "show deposit" do
      get :show, :id => Factory(:deposit, :user => @user).to_param
      assert_response :success
    end

    should "get edit" do
      get :edit, :id => Factory(:deposit, :user => @user).to_param
      assert_response :success
    end

    should "update deposit" do
      deposit = Factory(:deposit, :user => @user)
      put :update, :id => deposit.to_param, :deposit => deposit.attributes
      assert_redirected_to deposit_path(assigns(:deposit))
    end

    context "with a default deposit template" do
      setup do
        @fund1 = Factory(:fund, :user => @user)
        dt = Factory(:deposit_template, :user => @user, :default => true)
        dt.deposit_template_fund_percentages.build(:fund => @fund1, :percentage => 100)
        dt.save!
      end

      should "set percentages for new" do
        get :new
        deposit = assigns("deposit")
        assert_equal 100, deposit.fund_transactions[0].percentage
      end

      should "render new ok after adding a new fund" do
        Factory(:fund, :user => @user)
        get :new
        assert_response :success
      end
    end

    context "render for funds" do
      setup do
        @acc1 = Factory.create(:fund)
        @acc2 = Factory.create(:fund)
        @type = Factory.create(:deposit_template, :user => @user)
        @type.deposit_template_fund_percentages.build(:fund => @acc1, :percentage => 25).save!
        @type.deposit_template_fund_percentages.build(:fund => @acc2, :percentage => 75).save!
      end
      
      should "return values with amount empty" do
        get :funds, :type_id => @type.id
        result = assigns["result"]

        assert_equal 0, result[@acc1.id][:amount]
        assert_equal 25, result[@acc1.id][:percentage]
        assert_equal 0, result[@acc2.id][:amount]
        assert_equal 75, result[@acc2.id][:percentage]
      end

      should "return values with amount non empty" do
        get :funds, :type_id => @type.id, :amount => 100
        result = assigns["result"]

        assert_equal 25, result[@acc1.id][:amount]
        assert_equal 75, result[@acc2.id][:amount]
      end
    end
  end

  context "a deposit deposit template from another family" do
    setup do
      login
      @other = Factory(:deposit_template)
      assert @user.family != @other.user.family
    end

    should "should throw a record not found" do
      assert_raise ActiveRecord::RecordNotFound do
        get :funds, :type_id => @other.id
      end
    end
  end 
end
