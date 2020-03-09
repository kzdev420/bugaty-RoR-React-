class CreateSubscriptionPortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :subscription_portfolios do |t|
      t.string :background
      t.string :title
      t.string :title_1
      t.string :image_1
      t.text :description_1
      t.string :image_2
      t.string :title_2
      t.text :description_2
      t.string :image_3
      t.string :title_3
      t.text :description_3
      t.string :button_title

      t.timestamps
    end
  end
end
