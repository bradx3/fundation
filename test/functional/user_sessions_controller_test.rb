require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase

  should "render new" do
    get :new
    assert_response :success
  end

end
