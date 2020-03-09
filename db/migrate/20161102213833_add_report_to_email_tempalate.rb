class AddReportToEmailTempalate < ActiveRecord::Migration[5.0]
  def change
    add_column :email_templates, :report_ad, :text
  end
end
