class CreatePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :prices do |t|
      t.string :featured_home_price
      t.string :featured_cat_price
      t.string :featured_all_price
      t.string :urgent_price
      t.string :company_displayed_30_price
      t.string :company_displayed_90_price
      t.string :company_displayed_180_price
      t.string :company_displayed_365_price

      t.timestamps
    end
  end
end
