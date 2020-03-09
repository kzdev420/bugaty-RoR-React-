class CreateMyShopSections < ActiveRecord::Migration[5.0]
  def change
    create_table :my_shop_sections do |t|
      t.string :image
      t.string :title_before_sign
      t.text :description_before_sign
      t.string :title_after_sign
      t.text :description_after_sign

      t.timestamps
    end
  end
end
