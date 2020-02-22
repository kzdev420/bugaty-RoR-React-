class AddFiledToEmailTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :email_templates, :review_reply_alert, :text
  end
end
