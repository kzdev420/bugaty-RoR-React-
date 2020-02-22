class AddIndexToCountries < ActiveRecord::Migration[5.0]
  def change
    add_index :countries, :name
  end
end
