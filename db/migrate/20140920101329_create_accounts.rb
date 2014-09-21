class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :company_name
      t.timestamps
    end
    add_index :accounts, :user_id
  end
end
