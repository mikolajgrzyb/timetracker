class CreateAccountMembers < ActiveRecord::Migration
  def change
    create_table :account_members do |t|
      t.integer :account_id
      t.integer :user_id


      t.timestamps
    end

    add_index :account_members, :account_id
    add_index :account_members, :user_id
  end
end
