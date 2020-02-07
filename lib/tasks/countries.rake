desc 'Load countries from ISO 3166'

task :load_countries => :environment do
  require 'countries'

  continents = Continent.all

  continents.each do |cont|
    puts cont.name
    list = ISO3166::Country.find_all_countries_by_continent(cont.name)
    puts "#{list.size} countries"
    list.each do |cnt|
      country = cont.countries.create(name: cnt.name)
      puts cnt.name
      regions = []
      cnt.subdivisions.each_value { |obj| regions << obj['name'] }
      regions.map do |region_name|
        country.regions.create(name: region_name)
      end
    end
  end
end
