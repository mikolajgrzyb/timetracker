class CreateInvitationsTable < ActiveRecord::Migration
  def change
    create_table :invitations_tables do |t|
      t.string :token
      t.string :email
      t.references :account

      t.timestamps

      t.index :email
    end
  end
end
