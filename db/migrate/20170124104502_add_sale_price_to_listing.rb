class AddSalePriceToListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :sale_price, :integer
  end
end
