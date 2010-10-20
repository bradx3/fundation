ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "authlogic/test_case"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def self.should_require_user_for_all_methods
    should "have require_user as a filter" do
      filters = controller.class.send("_process_action_callbacks")
      filter = filters.detect do |filter|
        filter.filter == :require_user and filter.kind == :before
      end

      assert_not_nil filter, "No before filter found to require user"
    end
  end

  def self.should_keep_it_in_the_family(association)
    context "restricting #{ association } to family" do
      setup do
        login
        
        @other = Factory(association)
        other_family = @other.family if @other.respond_to?(:family)
        other_family ||= @other.user.family
        assert @user.family != other_family
      end
      
      should "not be able to show" do
        return if !controller.respond_to?(:show)

        assert_raise ActiveRecord::RecordNotFound do
          get :show, :id => @other.id
        end
      end

      should "not be able to edit" do
        return if !controller.respond_to?(:edit)

        assert_raise ActiveRecord::RecordNotFound do
          get :edit, :id => @other.id
        end
      end

      should "not be able to update" do
        return if !controller.respond_to?(:update)

        assert_raise ActiveRecord::RecordNotFound do
          put :update, :id => @other.id
        end
      end

      should "not be able to delete" do
        return if !controller.respond_to?(:destroy)

        assert_raise ActiveRecord::RecordNotFound do
          delete :destroy, :id => @other.id
        end
      end
    end
  end
end

class ActionController::TestCase
  setup :activate_authlogic
end

require "capybara/rails"
module ActionController
  class IntegrationTest
    include Capybara
  end
end

# require "webrat"
# Webrat.configure do |config|
#   config.mode = :rack
#   config.open_error_files = false
# end

def login
  @user ||= Factory(:user)
  UserSession.create(@user)
  assert_not_nil UserSession.find
end

def integration_login
  @user ||= Factory(:user)

  visit "/login"
  fill_in "Login", :with => @user.login
  fill_in "Password", :with => @user.password
  check "Remember me"
  click_button "Login"

  assert_not_nil UserSession.find
end

def synchronize(amount)
  visit "/"
  click_link "Synchronize"
  fill_in "Actual balance", :with => amount
  click_button "Synchronize"
  click_button "Create"
end

