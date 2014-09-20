class ChangeUserIdToOwnerIdInAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :user_id
    add_column :accounts, :owner_id, :integer
    add_index :accounts, :owner_id

  end
end
