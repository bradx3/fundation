class AddUserToDeposit < ActiveRecord::Migration
  def self.up
    add_column :deposits, :user_id, :integer
  end

  def self.down
    remove_column :deposits, :user_id
  end
end
