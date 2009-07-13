class CreateDepositTemplateAccountPercentages < ActiveRecord::Migration
  def self.up
    create_table :deposit_template_account_percentages do |t|
      t.integer :deposit_template_id
      t.integer :account_id
      t.integer :percentage

      t.timestamps
    end
  end

  def self.down
    drop_table :deposit_template_account_percentages
  end
end
