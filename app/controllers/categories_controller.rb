class CategoriesController < ApplicationController
  def show
    if params[:category_slug].present?
      @category = Category.friendly.find(params[:category_slug])
    else
      @category = Category.find(params[:id])
    end

    @search = Search.new
    @page = @category.listings
      .active
      .not_hidden
      .where(published: 2)
      .order('GREATEST(urgent_date, featured_cat_date) DESC NULLS LAST, created_at DESC')
      .page(params[:page])

    @listings_count = @page.total_entries

    listings_per_page

    @continents = Continent.all
  rescue ActiveRecord::RecordNotFound
    redirect_to controller: :errors, action: :not_found
  end

  private

  def listings_per_page
    if params[:pagination_select].present?
      @listings = @page.per_page(params[:pagination_select].to_i)
    elsif @category.id == 3 || @category.id == 4
      @listings = @page.per_page(12)
    else
      @listings = @page.per_page(10)
    end
  end
end
