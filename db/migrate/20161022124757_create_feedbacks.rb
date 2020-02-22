class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.string :image
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :position
      t.string :country
      t.text :content
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
