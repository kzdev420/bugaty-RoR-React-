class SubcategoriesController < ApplicationController

  def show

    if params[:category_slug].present?
      @category = Category.friendly.find(params[:category_slug])
      @subcategory = @category.subcategories.friendly.find(params[:subcategory_slug])
    else
      @subcategory = Subcategory.find(params[:id])
      @category = @subcategory.category
    end

    @search = Search.new(category_id: @subcategory.id)
    @page = @subcategory
      .listings
      .active
      .not_hidden
      .where(published: 2)
      .order('GREATEST(urgent_date, featured_cat_date) DESC NULLS LAST, created_at DESC')
      .page(params[:page])

    @listings_count = @page.total_entries

    @continents = Continent.all

		if params[:pagination_select].present?
			@listings = @page.per_page(params[:pagination_select].to_i)
		else
			@listings = @page.per_page(10)
		end
  end
end
