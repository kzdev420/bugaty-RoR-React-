class AddSubscribedUntilToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :subscribed_until, :datetime
  end
end
