class AddBlogHeaderMenuToTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :blog_header_menu, :string
  end
end
