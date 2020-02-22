class ChangePriceAgainInListings < ActiveRecord::Migration[5.0]
  def change
    change_column :listings, :price, :decimal, precision: 10, scale: 2
  end
end
