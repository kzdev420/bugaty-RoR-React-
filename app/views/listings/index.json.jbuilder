json.array!(@listings) do |listing|
  json.extract! listing, :id, :name, :category, :brand, :condition, :location, :description, :delivery_time, :delivery_cost, :price
  json.url listing_url(listing, format: :json)
end
