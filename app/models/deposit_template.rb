class DepositTemplate < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  belongs_to :user
  validates_presence_of :user

  has_many :deposit_template_fund_percentages
  accepts_nested_attributes_for :deposit_template_fund_percentages

  def init_all_fund_percentages
    funds = Fund.all
    percentages = self.deposit_template_fund_percentages
    set_funds = percentages.map { |d| d.fund }

    (funds - set_funds).each do |acc|
      percentages.build(:percentage => 0, :fund => acc)
    end
  end

end
