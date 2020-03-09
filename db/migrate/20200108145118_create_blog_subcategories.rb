class CreateBlogSubcategories < ActiveRecord::Migration[5.0]
  def change
    create_table :blog_subcategories do |t|
      t.string :title
      t.string :slug
      t.references :blog_category

      t.timestamps
    end
  end
end
