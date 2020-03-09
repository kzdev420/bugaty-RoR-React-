class PodcastResourceSerializer < ApplicationSerializer
  attributes :id, :cover_image, :url

  def cover_image
    object.cover_image&.url
  end

end
