class DepositType < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :deposit_type_account_percentages
  accepts_nested_attributes_for :deposit_type_account_percentages

  def init_all_account_percentages
    accounts = Account.all
    percentages = self.deposit_type_account_percentages
    set_accounts = percentages.map { |d| d.account }

    (accounts - set_accounts).each do |acc|
      percentages.build(:percentage => 0, :account => acc)
    end
  end

end
