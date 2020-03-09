class PodcastEpisode < ApplicationRecord
  extend FriendlyId
  validates_presence_of :title
  friendly_id :title, use: [:slugged, :finders]

  has_many :podcast_resources, dependent: :destroy
end
