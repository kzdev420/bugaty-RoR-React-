class AddIndexToCities < ActiveRecord::Migration[5.0]
  def change
    add_index :cities, :name
  end
end
