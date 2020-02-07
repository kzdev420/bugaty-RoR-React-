module SearchesHelper
  def ads_count(hsh = {})
    location = hsh[:continent] || @city || @region || @country || @continent
    return listings_count(hsh.values.first) if location.nil?

    if hsh.key?(:continent)
      hsh[:subcategory] = @subcategory if @subcategory.present?
      hsh[:category] = @category if @category.present?
    end

    if hsh[:subcategory].present?
      listings_count(location, subcategory: hsh[:subcategory])
    elsif hsh[:category].present?
      listings_count(location, category: hsh[:category])
    else
      listings_count(location)
    end
  end

  def define_search_location
    location = ''
    if @city.present?
      location = "#{@region.name}, #{@city.name}"
    elsif @region.present?
      location = "#{@country.name}, #{@region.name}"
    else
      location = @country.try(:name) || @continent.try(:name) || ''
    end
    location
  end

  def listings_count(location, condition = nil)
    listings = location.listings.active.not_hidden
    listings = listings.where(condition) unless condition.nil?
    listings.size
  end

  def pagination_options
    if @category.present? && (@category.id == 3 || @category.id == 4)
      %w(12 24 60 120 600)
    else
      %w(10 25 50 100 500)
    end
  end

  def search_title
    title = @subcategory.try(:name) || @category.try(:name) || ''
    location_string = define_search_location
    location_string = "IN <strong>#{location_string}</strong>" unless location_string.empty?
    "#{@listings.total_entries} LISTINGS IN <strong>#{title}</strong> #{location_string} CLASSIFIEDS ADS"
  end
end
