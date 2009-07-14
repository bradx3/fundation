require 'test_helper'

class DepositTemplateTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_have_many :deposit_template_fund_percentages
  should_belong_to :user

  context "an existing deposit type" do
    setup do 
      Factory.create(:deposit_template)
    end

    should_validate_uniqueness_of :name
  end

  context "a normal deposit template" do
    should "ensure allocations add to 100%" do
      dt = Factory.build(:deposit_template)
      dt.deposit_template_fund_percentages.clear

      f1 = Factory(:fund)
      f2 = Factory(:fund)
      
      dt.deposit_template_fund_percentages.build(:percentage => 25, :fund => f1)
      dt.deposit_template_fund_percentages.build(:percentage => 25, :fund => f2)
      assert !dt.valid?

      dt.deposit_template_fund_percentages.last.percentage = 75
      assert dt.valid?
    end
  end

end
