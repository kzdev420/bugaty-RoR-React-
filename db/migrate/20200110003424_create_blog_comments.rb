class CreateBlogComments < ActiveRecord::Migration[5.0]
  def change
    create_table :blog_comments do |t|
      t.references :user, foreign_key: true
      t.string :content
      t.string :status
      t.references :blog_post, foreign_key: true

      t.timestamps
    end
  end
end
