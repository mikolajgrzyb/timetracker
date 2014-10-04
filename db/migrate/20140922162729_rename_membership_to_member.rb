class RenameMembershipToMember < ActiveRecord::Migration
  def change
    rename_table :memberships, :members
  end
end
