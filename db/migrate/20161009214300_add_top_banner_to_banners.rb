class AddTopBannerToBanners < ActiveRecord::Migration[5.0]
  def change
    add_column :banners, :banner_header_top, :text
  end
end
