class AddTokenToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :token, :string
    add_index :accounts, :token
  end
end
