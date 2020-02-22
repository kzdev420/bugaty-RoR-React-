class CreateFavoriteListings < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_listings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :listing, index: true

      t.timestamps
    end
  end
end
