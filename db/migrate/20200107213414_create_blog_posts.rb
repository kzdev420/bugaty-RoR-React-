class CreateBlogPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :content
      t.string :cover_photo
      t.string :author
      t.string :author_photo
      t.string :author
      t.string :bio
      t.text :tag
      t.boolean :featured

      t.timestamps
    end
  end
end
