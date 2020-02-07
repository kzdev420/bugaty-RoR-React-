desc 'Load cities from MaxMind database'

task :load_cities => :environment do
  CS.update

  City.delete_all
  Region.delete_all

  country_list = CS.countries
  countries = Country.all
  countries.find_each do |country|
    c = country_list.select { |key, value| value == country.name }
    c.each_key do |country_key|
      regions = CS.states(country_key)
      regions.each_pair do |region_key, region_name|
        region = country.regions.create(name: region_name)
        puts "Added #{region_name} region to #{country.name}"
        cities = CS.cities(region_key, country_key)
        city_count = 0
        cities.map do |city_name|
          region.cities.create(name: city_name)
          city_count += 1
        end
        puts "*** There are #{city_count} cities in #{region_name}"
      end
    end
  end
end
