class AddCompanyFiledsToListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :company_country, :string
    add_column :listings, :company_phone, :string
    add_column :listings, :company_website, :string
    add_column :listings, :company_tags, :string
    add_column :listings, :company_facebook, :string
    add_column :listings, :company_twitter, :string
    add_column :listings, :company_googleplus, :string
    add_column :listings, :company_instagram, :string
    add_column :listings, :company_linkedin, :string
    add_column :listings, :company_displayed, :integer
    add_column :listings, :company_display_time, :datetime

  end
end
