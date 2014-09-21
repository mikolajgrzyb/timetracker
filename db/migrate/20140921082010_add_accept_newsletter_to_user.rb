class AddAcceptNewsletterToUser < ActiveRecord::Migration
  def change
    add_column :users, :accept_newsletter, :boolean
  end
end
