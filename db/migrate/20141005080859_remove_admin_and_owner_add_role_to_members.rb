class RemoveAdminAndOwnerAddRoleToMembers < ActiveRecord::Migration
  def change
    add_column :members, :role, :integer
    remove_column :members, :admin
    remove_column :members, :owner
  end
end
