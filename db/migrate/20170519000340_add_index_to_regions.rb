class AddIndexToRegions < ActiveRecord::Migration[5.0]
  def change
    add_index :regions, :name
  end
end
