class CreatePodcastResources < ActiveRecord::Migration[5.0]
  def change
    create_table :podcast_resources do |t|
      t.string :cover_image
      t.string :url
      t.references :podcast_episode, foreign_key: true

      t.timestamps
    end
  end
end
