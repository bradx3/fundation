require 'test_helper'

class WithdrawalsControllerTest < ActionController::TestCase
  should_require_user_for_all_methods
  should_keep_it_in_the_family(:withdrawal)

  context "with a logged in user" do
    setup do
      login
    end

    should "get new" do
      get :new
      assert_response :success
    end

  end
end
