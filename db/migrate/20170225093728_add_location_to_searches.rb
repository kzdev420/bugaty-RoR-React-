class AddLocationToSearches < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :location, :string
  end
end
