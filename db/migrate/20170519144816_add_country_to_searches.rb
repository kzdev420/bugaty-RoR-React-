class AddCountryToSearches < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :continent_id, :integer
    add_column :searches, :country_id, :integer
    add_column :searches, :region_id, :integer
    add_column :searches, :city_id, :integer
  end
end
