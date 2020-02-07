class AddPausedToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :paused, :boolean, null: false, default: false
  end
end
