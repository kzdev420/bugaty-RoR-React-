class AddStripeIdToSubscriptionPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :subscription_plans, :stripe_id, :text
  end
end
