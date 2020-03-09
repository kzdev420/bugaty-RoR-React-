class MyShopSection < ApplicationRecord
    mount_uploader :image, CoverUploader
end
