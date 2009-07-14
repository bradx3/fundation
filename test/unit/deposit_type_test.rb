require 'test_helper'

class DepositTemplateTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_have_many :deposit_template_fund_percentages

  context "an existing deposit type" do
    setup do 
      Factory.create(:deposit_template)
    end

    should_validate_uniqueness_of :name
  end

end
