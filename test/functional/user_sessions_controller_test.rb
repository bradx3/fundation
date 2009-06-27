require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase

  context "with no logged in user" do
    should "render new" do
      get :new
      assert_response :success
    end
  end

  context "with a logged in user" do
    setup do
    end
  end

end
