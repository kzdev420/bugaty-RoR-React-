class PodcastHostSerializer < ApplicationSerializer
  attributes :description, :profile_picture_1, :profile_picture_2

  def profile_picture_1
    object.profile_picture_1&.url
  end

  def profile_picture_2
    object.profile_picture_2&.url
  end
end
