class CreateFunds < ActiveRecord::Migration
  def self.up
    create_table :funds do |t|
      t.string :name
      t.integer :initial_balance_in_cents, :default => 0
      t.boolean :default_synchronize_fund, :default => false
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :funds
  end
end
