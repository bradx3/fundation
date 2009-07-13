class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.integer :initial_balance_in_cents

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
