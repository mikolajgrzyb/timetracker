class AddFlagsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :owner, :boolean
    add_column :accounts, :admin, :boolean
  end
end
