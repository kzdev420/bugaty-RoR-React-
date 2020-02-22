class AddMetaToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :seo_keywords, :string
    add_column :listings, :seo_description, :text
  end
end
