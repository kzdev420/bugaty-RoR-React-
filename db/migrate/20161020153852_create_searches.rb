class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :keywords
      t.integer :category_id
      t.decimal :min_price
      t.decimal :max_price

      t.timestamps
    end
  end
end
