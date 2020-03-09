class CreateMembershipLandingpageThirdSections < ActiveRecord::Migration[5.0]
  def change
    create_table :membership_landingpage_third_sections do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
