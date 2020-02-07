class PodcastResource < ApplicationRecord
  belongs_to :podcast_episode
  mount_uploader :cover_image, AvatarUploader
end
