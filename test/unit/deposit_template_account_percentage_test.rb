require 'test_helper'

class DepositTemplateFundPercentageTest < ActiveSupport::TestCase
  should_belong_to :deposit_template
  should_belong_to :fund
end
