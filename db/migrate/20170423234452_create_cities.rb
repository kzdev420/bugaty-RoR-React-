class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :title
      t.string :keywords
      t.text :content
      t.text :description

      t.references :region, foreign_key: true
    end
  end
end
