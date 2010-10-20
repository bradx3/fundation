require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should belong_to :family
  should validate_presence_of :family
  should have_many :funds
  should have_many :deposit_templates
end
