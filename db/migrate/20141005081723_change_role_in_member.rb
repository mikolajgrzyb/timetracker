class ChangeRoleInMember < ActiveRecord::Migration
  def change
    change_column :members, :role, :integer, default: 0
  end
end
