class Photo < ApplicationRecord
	belongs_to :listing

	mount_uploader :image, ListingImageUploader
  validates :image, file_size: { less_than: 2.megabytes }
end
