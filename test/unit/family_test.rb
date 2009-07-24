require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  should_have_many :users
  should_have_many :funds, :through => :users
  should_have_many :deposit_templates, :through => :users

  context "a normal family" do
    setup do
      @user = Factory(:user)
      @family = @user.family
    end

    context "with a number of funds" do
      setup do
        4.times { Factory(:fund, :user => @user) }
      end

      should "return no synchronize_fund if none set" do
        assert_nil @family.synchronize_fund
      end

      should "return no synchronize_fund if one set" do
        @family.funds[2].default_synchronize_fund = true
        assert_equal @family.funds[2], @family.synchronize_fund
      end
    end
  end
end
