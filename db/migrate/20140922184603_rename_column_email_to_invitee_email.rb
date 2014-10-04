class RenameColumnEmailToInviteeEmail < ActiveRecord::Migration
  def change
    rename_column :invitations, :email, :invitee_email
  end
end
