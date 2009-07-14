class CreateFundTransactions < ActiveRecord::Migration
  def self.up
    create_table :fund_transactions do |t|
      t.integer :transaction_id
      t.integer :fund_id
      t.integer :percentage
      t.integer :amount_in_cents

      t.timestamps
    end
  end

  def self.down
    drop_table :fund_transactions
  end
end
