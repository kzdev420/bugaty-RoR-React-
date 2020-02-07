class AddRefToCommentReply < ActiveRecord::Migration[5.0]
  def change
    add_reference :comment_replies, :comment
  end
end
