class RemoveTokenFromAccount < ActiveRecord::Migration
  def change
    remove_column :accounts, :token, :string
  end
end
