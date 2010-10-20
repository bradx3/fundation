require 'test_helper'

class DepositTemplateFundPercentageTest < ActiveSupport::TestCase
  should belong_to :deposit_template
  should belong_to :fund
end
