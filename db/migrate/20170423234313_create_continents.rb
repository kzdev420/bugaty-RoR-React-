class CreateContinents < ActiveRecord::Migration[5.0]
  def change
    create_table :continents do |t|
      t.string :name, null: false
      t.string :title
      t.string :keywords
      t.text :content
      t.text :description
    end
  end
end
