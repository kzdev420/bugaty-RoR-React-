class AddCompanyYoutubeToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :company_youtube, :string
  end
end
