require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  should_validate_presence_of :name

end
