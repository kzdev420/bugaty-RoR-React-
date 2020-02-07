class PodcastHost < ApplicationRecord

  mount_uploader :profile_picture_1, AvatarUploader
  mount_uploader :profile_picture_2, AvatarUploader

end
