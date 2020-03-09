class CreateSubscriptionPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :subscription_plans do |t|
      t.string :period
      t.decimal :price, null: false, default: 0.0

      t.timestamps
    end
  end
end
