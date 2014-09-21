class RenameColumnAccountMembers < ActiveRecord::Migration
  def change
    rename_table :account_members, :memberships
  end
end
