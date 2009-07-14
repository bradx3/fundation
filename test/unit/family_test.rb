require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  should_have_many :users
end
