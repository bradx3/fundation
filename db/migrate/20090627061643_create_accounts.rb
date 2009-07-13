class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.integer :initial_balance_in_cents, :default => 0
      t.boolean :default_synchronize_fund, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
