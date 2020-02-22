class AddFiledsToSearch < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :main_category, :string
    add_column :searches, :distance, :string
    add_column :searches, :showonly, :string
    add_column :searches, :sortby, :string

    add_column :searches, :car_make, :string
    add_column :searches, :car_model, :string
    add_column :searches, :car_age, :string
    add_column :searches, :car_mileage, :string
    add_column :searches, :car_engine_size, :string
    add_column :searches, :property_type, :string

  end
end
