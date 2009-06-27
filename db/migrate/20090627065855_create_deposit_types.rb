class CreateDepositTypes < ActiveRecord::Migration
  def self.up
    create_table :deposit_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :deposit_types
  end
end
