class AddDealFieldsToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :deal_url, :string
    add_column :listings, :deal_expire_time, :datetime
    add_column :listings, :deal_coupon, :string
  end
end
