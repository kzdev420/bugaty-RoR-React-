class CreatePodcastEpisodes < ActiveRecord::Migration[5.0]
  def change
    create_table :podcast_episodes do |t|
      t.string :title
      t.string :slug
      t.string :small_description
      t.string :content
      t.string :embedded_podcast

      t.timestamps
    end
  end
end
