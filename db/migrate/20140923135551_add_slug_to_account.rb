class AddSlugToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :slug, :string
  end
end
