class AddCityToListings < ActiveRecord::Migration[5.0]
  def change
    add_reference :listings, :city, foreign_key: true, index: true
  end
end
