class AddColumnSubcategoryIdToBlogPost < ActiveRecord::Migration[5.0]
  def change
    add_reference :blog_posts, :blog_subcategory, foreign_key: true
  end
end
