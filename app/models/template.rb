class Template < ApplicationRecord
  mount_uploader :podcast_header_image, AvatarUploader
end
