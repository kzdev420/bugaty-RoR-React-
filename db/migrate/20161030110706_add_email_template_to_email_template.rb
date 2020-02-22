class AddEmailTemplateToEmailTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :email_templates, :email_global_header, :text
    add_column :email_templates, :email_global_footer, :text
  end
end
