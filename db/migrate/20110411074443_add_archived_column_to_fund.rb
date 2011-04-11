class AddArchivedColumnToFund < ActiveRecord::Migration
  def self.up
    add_column :funds, :archived, :boolean, :default => false
  end

  def self.down
    remove_column :funds, :archived
  end
end
