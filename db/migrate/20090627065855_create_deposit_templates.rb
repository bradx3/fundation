class CreateDepositTemplates < ActiveRecord::Migration
  def self.up
    create_table :deposit_templates do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :deposit_templates
  end
end
