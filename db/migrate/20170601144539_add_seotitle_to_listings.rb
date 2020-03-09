class AddSeotitleToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :seo_title, :string
  end
end
