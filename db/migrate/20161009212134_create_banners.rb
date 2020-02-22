class CreateBanners < ActiveRecord::Migration[5.0]
  def change
    create_table :banners do |t|
      t.text :banner_top
      t.text :banner_left_sidebar
      t.text :banner_right_sidebar_long
      t.text :banner_right_sidebar_short
      t.text :banner_bottom
      
      t.timestamps
    end
  end
end
