class AddEmailToEmailTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :email_templates, :listing_new_payment_user, :text
  end
end
