class AddPreviewPodcastToPodcastEpisode < ActiveRecord::Migration[5.0]
  def change
    add_column :podcast_episodes, :preview_podcast, :string
  end
end
