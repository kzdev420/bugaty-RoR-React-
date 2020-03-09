class Search < ApplicationRecord
  SORTBY_VALUES = [
    'Default',
    'Highest Price',
    'Lowest Price',
    'Newly listed',
    'Review count'
  ]

  DISTANCE_VALUES = %w(Default 5 10 15 20 50 75 100 150 200 500 750 1000 1500 2000)
  CAR_AGE_VALUES = ([['All', 1]] + (1.upto(9).map { |i| ["Up to #{i} year#{'s' if i != 1}", Time.now.year - i] }) + [['Over 10 years', 1800]]).to_h
  CAR_MILEAGE_VALUES = {
    'All' => 0,
    'Up to 15 000' => 15000,
    'Up to 30 000' => 30000,
    'Up to 60 000' => 60000,
    'Up to 80 000' => 80000,
    'Up to 100 000' => 100000,
    'Over 100 000' => 1000000
  }
  CAR_ENGINE_SIZE_VALUES = {
    'All' => 0,
    'Up to 999 cc' => 999,
    'Up to 1999 cc' => 1999,
    'Up to 2999 cc' => 2999,
    'Up to 3999 cc' => 3999,
    'Up to 4999 cc' => 4999,
    'Over 4999 cc' =>  19999
  }
  PROPERTY_TYPE_VALUES = %w(House Caravan Shop Flat Unit Land Room Office Other)
  CONDITION_VALUES = [
    'New',
    'Used',
    'Refurbished',
    'For parts & not working',
    'other'
  ]

  def listings
    find_listings
  end

  def top_search
    find_top_listings
  end

  def clear!
    self.keywords = nil
    self.category_id = nil
    self.min_price = nil
    self.max_price = nil
    self.main_category = ''
    self.sortby = 'Default'
    self.car_make = nil
    self.car_model = nil
    self.car_age = nil
    self.car_mileage = nil
    self.car_engine_size = nil
    self.property_type = nil
    self.wholesale_min = nil
    self.wholesale_max = nil
    self.retail_min = nil
    self.retail_max = nil
    self.salary_min = nil
    self.salary_max = nil
    self.longitude = nil
    self.latitude = nil
    self.sale_min = nil
    self.sale_max = nil
    self.showonly = nil
    self.location = nil
    self.condition = nil
    self.continent_id = nil
    self.country_id = nil
    self.region_id = nil
    self.city_id = nil
    save!
  end

  private

  def find_listings
    if sortby.present?
      if sortby == 'Default'
        listings = Listing.order('GREATEST(urgent_date, featured_home_date, featured_cat_date) DESC NULLS LAST, created_at DESC')
      elsif sortby == 'Highest Price'
        listings = Listing.order('price DESC') # GREATEST(urgent_date, featured_all_date, featured_home_date, featured_cat_date) DESC NULLS LAST,
      elsif sortby == 'Lowest Price'
        listings = Listing.order('price ASC') # GREATEST(urgent_date, featured_all_date, featured_home_date, featured_cat_date) DESC NULLS LAST,
      elsif sortby == 'Newly listed'
        listings = Listing.order('created_at DESC') # GREATEST(urgent_date, featured_all_date, featured_home_date, featured_cat_date) DESC NULLS LAST,
      elsif sortby == 'Review count'
        listings = Listing.joins(:comments).group("listings.id").order("GREATEST(urgent_date, featured_home_date, featured_cat_date) DESC NULLS LAST,count(listings.id) DESC")
      end
    else
      listings = Listing.all.order('GREATEST(urgent_date, featured_home_date, featured_cat_date) DESC NULLS LAST, created_at DESC')
    end

    listings = listings.active.not_hidden

    listings = listings.where(category_id: main_category) unless main_category.blank?
    listings = listings.where(published: 2) # default to published

    if showonly.present?
      if showonly == 'featured'
        listings = listings.where("(featured_home = ? AND featured_home_date > ?) OR (featured_cat = ? AND featured_cat_date > ?)", "1", Time.now - 30.days, "1", Time.now - 30.days)
      end
      if showonly == 'urgent'
        listings = listings.where("urgent = ? AND urgent_date > ?", "1", Time.now - 30.days)
      end
      if showonly == 'reviewed'
        listings = listings.where("comments_count > ?", 0)
      end
      if showonly == 'fixed_price'
        listings = listings.where("price_per like ?", "Fixed")
      end
      if showonly == 'hourly_price'
        listings = listings.where("price_per like ?", "per hour")
      end
      ## jobs
      if showonly == 'permanent'
        listings = listings.where("job_type like ?", "%Permanent%")
      end
      if showonly == 'temporary'
        listings = listings.where("job_type like ?", "%Temporary%")
      end
      if showonly == 'part_time'
        listings = listings.where("job_type like ?", "%Part time%")
      end
      ## cars
      if showonly == 'petrol'
        listings = listings.where("car_fuel_type SIMILAR TO ?", "(petrol|Petrol)")
      end
      if showonly == 'diesel'
        listings = listings.where("car_fuel_type SIMILAR TO ?", "(diesel|Diesel)")
      end
      if showonly == 'automatic'
        listings = listings.where("car_gearbox SIMILAR TO ?", "(automatic|Automatic|auto|Auto|Robot)")
      end
      if showonly == 'manual'
        listings = listings.where("car_gearbox SIMILAR TO ?", "(manual|Manual)")
      end
    end

    if condition.present? && CONDITION_VALUES.include?(condition)
      listings = listings.where(condition: condition)
    end

    # Distance filter
    if distance.present? && distance != "Default" && location.present?
      location_lat, location_long = Geocoder.coordinates(location)
      listings = listings.near([location_lat, location_long], distance.to_i)
    elsif location.present?
      cities_list = find_location(location)
      listings = listings.where(city_id: cities_list)
    # countries
    elsif city_id.present?
      listings = listings.where(city_id: city_id)
    elsif region_id.present?
      region = Region.find(region_id)
      cities_list = region.cities.pluck(:id)
      listings = listings.where(city_id: cities_list)
    elsif country_id.present?
      country = Country.find(country_id)
      cities_list = country.cities.pluck(:id)
      listings = listings.where(city_id: cities_list)
    elsif continent_id.present?
      continent = Continent.find(continent_id)
      cities_list = continent.cities.pluck(:id)
      listings = listings.where(city_id: cities_list)
    end

    # main logics
    listings = listings.where("LOWER(name) LIKE ? OR ? = ANY(keywords)", "%#{keywords.downcase}%", "#{keywords.downcase}") if keywords.present?
    listings = listings.where(subcategory_id: category_id) if category_id.present?
    listings = listings.where("price >= ?", min_price) if min_price.present?
    listings = listings.where("price <= ?", max_price) if max_price.present?

    #retail
    listings = listings.where("wholesale_price >= ?", wholesale_min) if wholesale_min.present?
    listings = listings.where("wholesale_price <= ?", wholesale_max) if wholesale_max.present?
    listings = listings.where("sale_price >= ?", sale_min) if sale_min.present?
    listings = listings.where("sale_price <= ?", sale_max) if sale_max.present?
    listings = listings.where("retail_price >= ?", retail_min) if retail_min.present?
    listings = listings.where("retail_price <= ?", retail_max) if retail_max.present?

    # jobs
    listings = listings.where("price >= ?", salary_min) if salary_min.present?
    listings = listings.where("price <= ?", salary_max) if salary_max.present?

    # car
    if car_make.present? && car_make != '0'
      listings = listings.where("car_make like ?", "%#{car_make}%")
    end
    if car_model.present? && car_model != '0'
      listings = listings.where("car_model like ?", "%#{car_model}%")
    end
    if car_age.present? && car_age.to_i != 0
      listings = listings.where("car_reg_year >= ?", car_age)
    end
    if car_mileage.present? && car_mileage.to_i != 0
      listings = listings.where("car_mileage <= ?", car_mileage)
    end
    if car_engine_size.present? && car_engine_size.to_i != 0
      listings = listings.where("car_engine_size <= ?", car_engine_size.to_i)
    end

    #property
    listings = listings.where(property_type: property_type) if property_type.present?

    # retun result
    listings
  end

  def find_location(search_string)
    cities_list = []
    cities_list = City.
      where('LOWER(name) LIKE ?', "%#{search_string.downcase}%").pluck(:id)
    regions_list = Region.
      where('LOWER(name) LIKE ?', "%#{search_string.downcase}%").pluck(:id)
    unless regions_list.empty?
      cities_list += City.where(region_id: regions_list).pluck(:id)
    end
    countries_list = Country.
      where('LOWER(name) LIKE ?', "%#{search_string.downcase}%")
    cities_list += countries_list.collect { |c| c.cities.pluck(:id) }.flatten
  end

  ## TOP SEARCH

  def find_top_listings
    listings = Listing.active.order('created_at DESC')
    listings = listings.where(published: 2)
    listings = listings.where(category_id: main_category.to_i) if main_category.present?
    listings = listings.where("name like ?", "%#{keywords}%") if keywords.present?
    listings = listings.where("location like ?", "%#{distance}%") if distance.present?
    listings
  end
end
