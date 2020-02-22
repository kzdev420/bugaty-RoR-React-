class ChangeListingToFloats < ActiveRecord::Migration[5.0]
  def change
    change_column :listings, :car_engine_size, :float
  end
end
