class AddTotal < ActiveRecord::Migration[5.0]
  def change
  	add_column :listings, :total_amount_cents, :decimal
  	add_column :listings, :purchased_at, :datetime
  end
end
