class CreateAccountTransactions < ActiveRecord::Migration
  def self.up
    create_table :account_transactions do |t|
      t.integer :transaction_id
      t.integer :account_id
      t.integer :percentage
      t.integer :amount_in_cents

      t.timestamps
    end
  end

  def self.down
    drop_table :account_transactions
  end
end
