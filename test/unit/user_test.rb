require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should_belong_to :family
  should_validate_presence_of :family
end
