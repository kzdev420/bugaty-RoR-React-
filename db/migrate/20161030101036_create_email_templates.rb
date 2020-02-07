class CreateEmailTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :email_templates do |t|
      t.text :user_confirmation
      t.text :user_password_change
      t.text :user_reset_password
      t.text :user_unlock
      t.text :listing_new_admin
      t.text :listing_new_payment_admin
      t.text :contact_form_admin
      t.text :feedback_admin
      t.text :listing_message_user
      t.text :listing_job_user

      t.timestamps
    end
  end
end
