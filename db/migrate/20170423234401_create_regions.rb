class CreateRegions < ActiveRecord::Migration[5.0]
  def change
    create_table :regions do |t|
      t.string :name
      t.string :title
      t.string :keywords
      t.text :content
      t.text :description

      t.references :country, foreign_key: true
    end
  end
end
