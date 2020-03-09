class AddColumnStatusToBlogPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :blog_posts, :status, :string
  end
end
