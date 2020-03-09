class AddFiledsToListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :wholesale_price, :integer
    add_column :listings, :retail_price, :integer
    add_column :listings, :wholesale_moq, :string
  end
end
