class AddFlagsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :admin, :boolean
    add_column :members, :owner, :boolean
  end
end
