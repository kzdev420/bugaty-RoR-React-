class SubscriptionPortfolio < ApplicationRecord
    mount_uploader :background, CoverUploader
    mount_uploader :image_1, AvatarUploader
    mount_uploader :image_2, AvatarUploader
    mount_uploader :image_3, AvatarUploader
end
