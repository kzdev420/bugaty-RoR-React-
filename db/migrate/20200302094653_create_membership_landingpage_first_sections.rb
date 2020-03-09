class CreateMembershipLandingpageFirstSections < ActiveRecord::Migration[5.0]
  def change
    create_table :membership_landingpage_first_sections do |t|
      t.string :title
      t.string :image_title
      t.text :image_description
      t.string :background

      t.timestamps
    end
  end
end
