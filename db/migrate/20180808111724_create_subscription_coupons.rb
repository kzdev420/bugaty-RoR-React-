class CreateSubscriptionCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :subscription_coupons do |t|
      t.string :name, null: false
      t.string :stripe_id
      t.integer :state, null: false
      t.float :discount, null: false
    end
  end
end
