class CreateCommentReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_replies do |t|
      t.text :content
      t.string :title
      t.references :listing
      t.references :user

      t.timestamps
    end
  end
end
