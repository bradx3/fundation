require 'test_helper'

class DepositTemplateTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should have_many :deposit_template_fund_percentages
  should belong_to :user

  context "an existing deposit type" do
    setup do 
      Factory.create(:deposit_template)
    end

    should "validate uniqueness of name for user" do
      existing = DepositTemplate.first
      new = Factory.build(:deposit_template, :user => existing.user, 
                          :name => existing.name)
      new.valid?
      assert new.errors[:name].any?
    end
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
