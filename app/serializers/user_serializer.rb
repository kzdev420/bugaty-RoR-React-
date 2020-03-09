class UserSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :name, :profile_photo, :slug

  def name
    "#{object.first_name} #{object.last_name}"
  end

  def profile_photo
    object.profile_photo&.url
  end
end
