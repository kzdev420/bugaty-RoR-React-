class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :title
      t.string :keywords
      t.text :content
      t.text :description

      t.references :continent, foreign_key: true
    end
  end
end
