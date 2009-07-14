require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  should_have_many :users
  should_have_many :funds, :through => :users
  should_have_many :deposit_templates, :through => :users
end
