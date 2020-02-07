class RemoveFeaturedAllFromListings < ActiveRecord::Migration[5.0]
  def change
    remove_column :listings, :featured_all, :integer
    remove_column :listings, :featured_all_date, :datetime

    remove_column :prices, :featured_all_price, :string
  end
end
