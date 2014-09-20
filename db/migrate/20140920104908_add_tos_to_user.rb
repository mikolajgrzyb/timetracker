class AddTosToUser < ActiveRecord::Migration
  def change
    add_column :users, :tos_accepted, :boolean
  end
end
