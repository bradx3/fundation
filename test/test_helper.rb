ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require "authlogic/test_case"

class ActiveSupport::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def self.should_require_user_for_all_methods
    should "have require_user as a filter" do
      filter = controller.class.filter_chain.detect do |filter|
        filter.method == :require_user and
          (filter.class == ActionController::Filters::BeforeFilter)
      end

      assert_not_nil filter, "No before filter found to require user"
    end
  end
end

class ActionController::TestCase
  setup :activate_authlogic
end

require "webrat"

Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false
end

def login
  @user ||= Factory(:user)
  UserSession.create(@user)
  assert_not_nil UserSession.find
end

def integration_login
  @user ||= Factory(:user)

  visit "/login"
  fill_in "login", :with => @user.login
  fill_in "password", :with => @user.password
  check "remember me"
  click_button "Login"

   assert_not_nil UserSession.find
end


