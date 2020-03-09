class AddPaypalIdToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :paypal_id, :string
  end
end
