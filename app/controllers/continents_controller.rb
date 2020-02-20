class ContinentsController < ApplicationController
  def index
    @links = []
    Continent.find_each do |continent|
      country_links = country_links_for(continent)
      unless country_links.empty?
        @links << {
          name: "#{continent.name} Classifieds Ads",
          url: "/continents/#{continent.slug}",
          children: country_links
        }
      end
    end
    count_members
  end

  def show
    @continent = Continent.friendly.find(continent_params[:id])
    @links = country_links_for(@continent)
  end

  private

  def continent_params
    params.permit(:id)
  end

  def count_members
    @links.each do |item|
      item[:weight] = hash_size(item)
    end
  end

  def country_links_for(continent)
    continent.countries.order(:name).map do |country|
      {name: "#{country.name} classifieds ads",
       url: "/countries/#{country.slug}",
       weight: 1}
    end
  end

  def hash_size(obj)
    if obj.include?(:children)
      obj[:children].inject(0) { |sum, child| sum += hash_size(child) } + 1
    else
      1
    end
  end
end
