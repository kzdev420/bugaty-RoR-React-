class AddSubscriptionPlanReferenceToListings < ActiveRecord::Migration[5.0]
  def change
    add_reference :listings, :subscription_plan, index: true
    add_foreign_key :listings, :subscription_plans
  end
end
