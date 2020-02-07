class RenameCompanyTagsInListings < ActiveRecord::Migration[5.0]
  def change
    rename_column :listings, :company_tags, :old_company_tags
  end
end
