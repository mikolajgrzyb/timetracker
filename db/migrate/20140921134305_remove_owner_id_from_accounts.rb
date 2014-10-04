class RemoveOwnerIdFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :owner_id, :string
  end
end
