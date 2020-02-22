class AddSubscriptionStripeIdToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :subscription_stripe_id, :text
  end
end
