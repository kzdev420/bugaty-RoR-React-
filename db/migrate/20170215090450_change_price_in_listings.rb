class ChangePriceInListings < ActiveRecord::Migration[5.0]
  def change
    change_column :listings, :price, :decimal
  end
end
