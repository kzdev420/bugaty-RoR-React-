class CountriesController < ApplicationController
  LISTINGS_PER_PAGE = 10

  def show
    @country = Country.friendly.find(country_params[:id])
    @continent = Continent.find(@country.continent_id)
    @continents = Continent.all
    @countries = listings_count(@continent.countries.order(name: :desc))
    @regions = listings_count(@country.regions.order(name: :desc))

    @search = Search.new(continent_id: @continent.id, country_id: @country.id)
    @page = @country
      .listings
      .active
      .not_hidden
      .where(published: 2)
      .order('GREATEST(urgent_date, featured_cat_date) NULLS LAST, created_at DESC')
      .page(params[:page])

    pagination = params[:pagination_select] || LISTINGS_PER_PAGE
    @listings = @page.per_page(pagination)
  end

  private

  def country_params
    params.permit(:id)
  end

  def listings_count(items)
    return {} if items.empty?
    arr = items.map { |c| {c => c.listings.size} }
    arr
      .inject(&:merge)
      .select { |key, value| value > 0 }
      .sort_by { |key, value| value }
      .reverse
      .to_h
  end
end
