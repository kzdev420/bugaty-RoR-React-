class AddScriptTagsToBlogPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :blog_posts, :script_tags, :string
  end
end
