class CreateDepositTemplateFundPercentages < ActiveRecord::Migration
  def self.up
    create_table :deposit_template_fund_percentages do |t|
      t.integer :deposit_template_id
      t.integer :fund_id
      t.integer :percentage

      t.timestamps
    end
  end

  def self.down
    drop_table :deposit_template_fund_percentages
  end
end
