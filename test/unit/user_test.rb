require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should_belong_to :family
  should_validate_presence_of :family
  should_have_many :funds
  should_have_many :deposit_templates
end
