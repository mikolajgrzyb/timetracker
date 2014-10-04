class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :billable
      t.integer :estimated_number_of_hours
      t.float :default_hourly_rate
      t.string :currency
    end
  end
end
