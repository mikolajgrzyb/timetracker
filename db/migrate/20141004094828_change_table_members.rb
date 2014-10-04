class ChangeTableMembers < ActiveRecord::Migration
  def up
  	change_column :members, :active, :boolean, default: true
  end
end
