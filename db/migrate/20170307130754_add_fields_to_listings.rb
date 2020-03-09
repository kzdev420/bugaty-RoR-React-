class AddFieldsToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :key_features, :text, array: true, default: []
    add_column :listings, :keywords, :text, array: true, default: []
    add_column :listings, :cancellations_and_returns, :text
    add_column :listings, :warranty, :text
  end
end
