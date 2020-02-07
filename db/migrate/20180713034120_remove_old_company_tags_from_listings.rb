class RemoveOldCompanyTagsFromListings < ActiveRecord::Migration[5.0]
  def change
    remove_column :listings, :old_company_tags, :string
  end
end
