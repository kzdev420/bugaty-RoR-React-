class AddCompanyTagsToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :company_tags, :string, array: true, default: []
  end
end
