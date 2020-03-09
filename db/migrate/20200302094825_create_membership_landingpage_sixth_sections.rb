class CreateMembershipLandingpageSixthSections < ActiveRecord::Migration[5.0]
  def change
    create_table :membership_landingpage_sixth_sections do |t|
      t.string :background
      t.string :title
      t.text :description
      t.string :button_title

      t.timestamps
    end
  end
end
