class CreateSupportArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :support_articles do |t|
      t.string :name
      t.text :content
      t.integer :support_topic_id

      t.timestamps
    end
  end
end
