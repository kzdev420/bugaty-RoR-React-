desc 'Set country/region/city for listings according geocoordinates'

task :update_location => :environment do
  listings = Listing.where(city_id: nil)
  puts "There are #{listings.size} listings without city_id in database"
  listings.find_each do |listing|
    results = Geocoder.search([listing.latitude, listing.longitude])
    next if results.nil?
    result = results.first
    country = Country.find_by(name: result.country)
    next unless country.present?
    cities = country.cities.where(name: result.city)
    listing.update(city_id: cities.first.id) if cities.size == 1
  end
  listing_count = Listing.where(city_id: nil).size
  puts "There are still #{listing_count} listings without city_id in database"
end
