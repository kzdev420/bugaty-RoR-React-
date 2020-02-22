class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.string :facebook_link
      t.string :twitter_link
      t.string :googleplus_link
      t.string :youtube_link

      t.text :mainpage_slider
      t.text :about_slider
      t.text :about_text
      t.text :contact_details
      t.text :feedback_slider
      t.text :feedback_text
      t.text :support_slider

      t.text :footer_text
      t.text :safety_text
      

      t.timestamps
    end
  end
end
