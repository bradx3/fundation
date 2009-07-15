class DepositTemplate < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  belongs_to :user
  validates_presence_of :user

  has_many :deposit_template_fund_percentages, :order => "id asc"
  accepts_nested_attributes_for :deposit_template_fund_percentages

  validate :percentages_add_up

  def init_all_fund_percentages
    funds = user.family.funds
    percentages = self.deposit_template_fund_percentages
    set_funds = percentages.map { |d| d.fund }

    (funds - set_funds).each do |acc|
      percentages.build(:percentage => 0, :fund => acc)
    end
  end

  def allocated_percentage
    deposit_template_fund_percentages.inject(0) do |total, dtfp| 
      total += dtfp.percentage
    end
  end

  private 

  def percentages_add_up
    allocated = allocated_percentage
    if allocated > 0 and allocated != 100.0
      errors.add_to_base("All money must be allocated in a deposit template")
    end
  end

end
