class CreateSliderTexts < ActiveRecord::Migration[5.0]
  def change
    create_table :slider_texts do |t|
      t.string :header
      t.string :slogan
    end
  end
end
