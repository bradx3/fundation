class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.string :type
      t.integer :amount_in_cents
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
