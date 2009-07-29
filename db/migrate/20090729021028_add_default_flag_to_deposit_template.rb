class AddDefaultFlagToDepositTemplate < ActiveRecord::Migration
  def self.up
    add_column :deposit_templates, :default, :boolean
  end

  def self.down
    remove_column :deposit_templates, :default
  end
end
