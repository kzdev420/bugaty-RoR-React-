class AddOpeningHoursToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :opening_hours, :text, array: true, default: []
  end
end
