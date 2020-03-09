class CreateHelpCenterSections < ActiveRecord::Migration[5.0]
  def change
    create_table :help_center_sections do |t|
      t.string :background
      t.string :title
      t.string :mini_title
      t.string :title_1
      t.text :description_1
      t.string :title_2
      t.text :description_2
      t.string :title_3
      t.text :description_3
      t.string :button_title
      
      t.timestamps
    end
  end
end
