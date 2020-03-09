class SearchController < ApplicationController
  def search

    define_location

    if params[:continent_id].present?
      @search = Search.new(continent_params)
    elsif params[:search].present?
			@search = Search.new(search_params)
		else
			@search = Search.new
		end

    define_countries

    @search.latitude = @latitude
    @search.longitude = @longitude

    @category = Category.find(@search.main_category.to_i) if @search.main_category.present?
    @subcategory = Subcategory.find(@search.category_id.to_i) if @search.category_id.present?

    ads_per_page = params[:pagination_select].to_i.nonzero? || 10
    page = params[:page].to_i.nonzero? || 1

    @listings = @search.listings.page(page).per(ads_per_page)
  end

  private

  def continent_params
    params.permit(:continent_id)
  end

  def search_params
    params.require(:search).permit(
      :latitude, :longitude, :keywords, :category_id, :min_price, :max_price,
      :main_category, :distance, :showonly,  :sortby,:car_make, :car_model,
      :car_age, :car_mileage, :car_engine_size, :property_type, :wholesale_min,
      :wholesale_max, :sale_min, :sale_max,  :retail_min, :retail_max,
      :salary_min, :salary_max, :location, :condition, :continent_id,
      :country_id, :region_id, :city_id
    )
  end

  def define_countries
    @continents = Continent.all

    return unless @search.continent_id.present?

    @continent = Continent.find(@search.continent_id)
    countries = @continent.countries.order(name: :desc)
    @countries = listings_count(countries)
    return unless @search.country_id.present?

    @country = Country.find(@search.country_id)
    unless countries.include?(@country)
      @search.country_id = nil
      @search.region_id = nil
      @search.city_id = nil
      @country = nil
      return
    end

    regions = @country.regions
    @regions = listings_count(regions)
    return unless @search.region_id.present?

    @region = Region.find(@search.region_id)
    if regions.include?(@region)
      @cities = listings_count(@region.cities)
      @search.city_id = nil unless @region.cities.pluck(:id).include?(@search.city_id)
      @city = City.find(@search.city_id) if @search.city_id.present?
    else
      @search.region_id = nil
      @search.city_id = nil
      @region = nil
    end
  end

  def define_location
	# if have geolocation cookies
	if !cookies[:geolocation].nil?
      @location = JSON.parse(cookies[:geolocation]).symbolize_keys
	else
	  # or detect by ip
      @ip = request.remote_ip
      if Rails.env.production?
        locale = request.location
        @location = locale.nil? ? GeoIp.geolocation(@ip) : {longitude: locale.longitude, latitude: locale.latitude}
      else
        @location = GeoIp.geolocation("217.66.158.12")
      end
	end
	@latitude = @location[:latitude]
	@longitude = @location[:longitude]
	cookies[:geolocation] = { value: JSON.generate(@location), expires: Time.now + 3600 * 24 * 7 }

  end

  def listings_count(items)
    return items.to_h if items.empty?
    if @search.category_id.present?
      arr = items.map { |c| {c => c.listings.where(subcategory_id: @search.category_id).size} }
    elsif @search.main_category.present?
      arr = items.map { |c| {c => c.listings.where(category_id: @search.main_category).size} }
    else
      arr = items.map { |c| {c => c.listings.size} }
    end
    arr.inject(&:merge).select { |key, value| value > 0 }.sort_by { |key, value| value }.reverse.to_h
  end
end
