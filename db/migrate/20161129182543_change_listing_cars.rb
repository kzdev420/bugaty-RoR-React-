class ChangeListingCars < ActiveRecord::Migration[5.0]
  def change
  	change_column :listings, :car_reg_year, "integer USING NULLIF(car_reg_year, '')::int"
  	change_column :listings, :car_mileage, "integer USING NULLIF(car_mileage, '')::int"
  	change_column :listings, :car_engine_size, "integer USING NULLIF(car_engine_size, '')::int"
  end
end
