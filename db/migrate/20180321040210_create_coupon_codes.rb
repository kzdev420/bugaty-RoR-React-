class CreateCouponCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :coupon_codes do |t|
      t.string :name, limit: 20, null: false
      t.float :discount, null: false
      t.date :expiration_date, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :coupon_codes, [:user_id, :name]
  end
end
