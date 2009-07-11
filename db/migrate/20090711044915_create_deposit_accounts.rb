class CreateDepositAccounts < ActiveRecord::Migration
  def self.up
    create_table :deposit_accounts do |t|
      t.integer :deposit_id
      t.integer :account_id
      t.integer :percentage
      t.integer :amount_in_cents

      t.timestamps
    end
  end

  def self.down
    drop_table :deposit_accounts
  end
end
