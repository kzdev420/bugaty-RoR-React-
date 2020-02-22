class AddTagsToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :tags, :string, array: true, default: []
  end
end
