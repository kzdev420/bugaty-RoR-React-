class AddFieldsToSearch < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :wholesale_min, :decimal
    add_column :searches, :wholesale_max, :decimal
    add_column :searches, :retail_min, :decimal
    add_column :searches, :retail_max, :decimal
    add_column :searches, :salary_min, :decimal
    add_column :searches, :salary_max, :decimal
  end
end
