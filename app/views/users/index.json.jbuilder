json.array!(@users) do |user|
  json.extract! user, :id, :email, :password, :phone, :language, :location, :last_active
  json.url user_url(user, format: :json)
end
