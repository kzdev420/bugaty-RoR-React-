class AddClicksToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :clicks, :integer, default: 0
    add_column :listings, :last_click_at, :datetime
  end
end
