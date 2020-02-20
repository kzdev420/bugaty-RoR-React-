class ListingsController < InheritedResources::Base

  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :destroy]
  before_action :remove_empty_query_params, except: [:update_countries, :update_regions, :update_cities]

  def index
    if params[:search]
      @listings = Listing.search(params[:search])
    else
      @listings = Listing
        .active
        .not_hidden
        .order('GREATEST(urgent_date, featured_home_date, featured_cat_date) DESC NULLS LAST, created_at DESC')
    end
    if params[:search_loc]
      @listings = Listing.search(params[:search_loc])
    end
  end

  def tag
    @page = Listing
      .active
      .not_hidden
      .where("?=ANY(tags)", params[:tag])
      .order('GREATEST(urgent_date, featured_cat_date) DESC NULLS LAST, created_at DESC')
      .page(params[:page])

    listings_per_page = params[:pagination_select].present? ? params[:pagination_select].to_i : 12
    @listings = @page.per_page(listings_per_page)

    @search = Search.new
    @category = Category.friendly.find('content')
    @continents = Continent.all
    @tag = params[:tag]
  end

  def show
    @listing = Listing.friendly.find(params[:id])
    @category = @listing.category_id
    @video_url = @listing.video_url if @listing.video_url.present?

    @user_ads = Listing.active.where(user_id: @listing.user.id, published: 2)
    @user_services = Listing.active.where(user_id: @listing.user.id, category_id: 4, published: 2)
    @user_jobs = Listing.active.where(user_id: @listing.user.id, category_id: 5, published: 2)
    @user_content = Listing.active.where(user_id: @listing.user.id, category_id: 25, published: 2)
    clicks = @listing.clicks + 1
    @listing.update(clicks: clicks, last_click_at: DateTime.now)
  end

  def new
    @category = Category.find_by_id(params[:id])
    @listing = @category.listings.new()
    @selected_category = params[:id]
    define_countries
  end

  def toggle_pause
    @listing = current_user.listings.friendly.find(params[:id])
    @listing.toggle_pause
    redirect_to user_all_listings_path(current_user)
  end

  def batch_delete
    @listings = current_user.listings.where(id: params[:listings].split(','))
    @listings.destroy_all
    redirect_to user_all_listings_path(current_user)
  end

  def batch_pause
    @listings = current_user.listings.where(id: params[:listings].split(','))
    @listings.update_all(paused: true)
    redirect_to user_all_listings_path(current_user)
  end

  def batch_unpause
    @listings = current_user.listings.where(id: params[:listings].split(','))
    @listings.update_all(paused: false)
    redirect_to user_all_listings_path(current_user)
  end

  def create
    category = Category.find_by_id(listing_params[:category_id])

    if category.payable?
      trial_period_end = 1.month.from_now
      published = current_user.nomoderation? ? 2 : 1
    else
      published = 2
      trial_period_end = 100.years.from_now
    end

    @listing = current_user.listings.build(listing_params.merge(published: published, subscribed_until: trial_period_end))
    @listing.company_display_time = Time.current if @listing.category_id == 1

    if @listing.save
      NewListingMailer.new_listing_mail_to_admin(@listing).deliver_later # send email to admin
      NewListingMailer.new_listing_mail_to_user(@listing).deliver_later unless current_user.nomoderation # send email to user with published:1

      if @listing.company_displayed == 1
        current_user.update(company_free_available: 0)
      end

      if current_user.nomoderation? || !category.payable?
        flash[:success] = "New listing was just created."
      else
        flash[:success] = "New listing was just created. It will be reviewed shortly and you'll get an email notification about the process."
      end

      redirect_to @listing
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @listing = current_user.listings.friendly.find(params[:id])
    @category = @listing.category
    if @listing.city.present?
      @cities = @listing.region.cities.order(:name)
      @regions = @listing.country.regions.order(:name)
      @countries = @listing.continent.countries.order(:name)
      @continents = Continent.all
    else
      define_countries
    end
  end

  def update
    @listing = current_user.listings.friendly.find(params[:id])

    @listing.published = 2 if current_user.nomoderation && @listing.published != 3

    if @listing.update_attributes(listing_params)
      if @listing.unpaid?
        flash[:success] = "Your listing was successfully updated. Please pay the featured options"
        redirect_to stripe_checkout_path(@listing)
        return
      end

      flash[:success] = "Your listing was successfully updated."
      redirect_to listing_path(@listing)

    else
      flash[:error] = "An error occurs while updating your listing. Please try again"
      redirect_to :back
    end

  end

  def send_message
    @listing = Listing.friendly.find(params[:id])
    if current_user
      @sender = current_user.email
    else
      @sender = params[:sender_email]
    end

    respond_to :json

    if verify_recaptcha
      SendMessageMailer.new_user_listing_email(@listing, params[:message], @sender).deliver_later # send email to admin
      render json: nil, status: :ok
    else
      render json: nil, status: 422
    end
  end

  def destroy
    @listing = Listing.friendly.find(params[:id])
    @listing.destroy
    redirect_to :back
    flash[:danger] = "Listing was successfully deleted."
  end

  def job_message
    @listing = Listing.friendly.find(params[:id])
    if current_user
      @sender = current_user.email
    else
      @sender = params[:sender_email]
    end

    respond_to do |format|

      if params[:message].length > 10 && verify_recaptcha(model: @listing)
        file_data = params[:upload]
        @filename = params[:upload].original_filename

        if file_data.respond_to?(:read)
          @file = params[:upload].read
        elsif file_data.respond_to?(:path)
          @file = File.read(file_data.path)
        else
           logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
        end

        SendMessageMailer.new_user_job_email(@listing, params[:message], @sender, @file, @filename).deliver_now
        format.json { render json: nil, status: :ok }
        format.html{
          flash[:info] = "Thank you! Your job application was sucesfully submited"
          redirect_to :back
        }
      else
        format.json { render json: nil, status: 422}
        format.html {
          flash[:error] = "Sorry, something went wrong. Please try again"
          redirect_to :back
        }
      end
    end
  end

  def report_ad
    @listing = Listing.friendly.find(params[:id])
    respond_to :json

    if params[:report_subject].length > 2
      SendMessageMailer.new_report_ad(@listing, params[:message], params[:report_subject]).deliver_later # send email to admin
      render json: nil, status: :ok
    else
      render json: nil, status: 422
    end
  end

  def favorite
    @listing = Listing.friendly.find(params[:id])
    type = params[:type]
    if type == "favorite"
      current_user.favorites << @listing
      redirect_to :back, notice: "You favorited #{@listing.name}"

    elsif type == "unfavorite"
      current_user.favorites.delete(@listing)
      redirect_to :back, notice: "Unfavorited #{@listing.name}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end

  def new_comment
    @listing = Listing.friendly.find(params[:id])
    if current_user

      comment_item = {
        user_id: current_user.id,
        rating: params[:rating],
        content: params[:content],
        title: params[:title],
        listing_id: @listing.id
      }
      @comment = current_user.comments.build(comment_item)

      if @comment.save
        NewListingMailer.new_comment_listing(@listing, @comment).deliver_later
        flash[:success] = "Thank you. Review sucesfully added"
        redirect_to :back
      end

    else
      redirect_to new_user_session_path
    end
  end

  def new_comment_reply
    @listing = Listing.friendly.find(params[:id])
    if current_user

      comment_item = {
        user_id: current_user.id,
        content: params[:content],
        title: params[:title],
        listing_id: @listing.id,
        comment_id: params[:comment_id]
      }
      @comment = current_user.comment_replies.build(comment_item)

      if @comment.save
        NewListingMailer.new_comment_reply_listing(@listing, @comment).deliver_later
        flash[:success] = "Thank you. Review reply sucesfully added"
        redirect_to :back
      end

    else
      redirect_to new_user_session_path
    end

  end

  def update_countries
    @countries = Country.where(continent_id: params[:cont_id]).order(:name)
    respond_to do |format|
      format.js
    end
  end

  def update_regions
    @regions = Region.where(country_id: params[:country_id]).order(:name)
    respond_to do |format|
      format.js
    end
  end

  def update_cities
    @cities = City.where(region_id: params[:region_id]).order(:name)
    respond_to do |format|
      format.js
    end
  end

  private

    def listing_params
      params.require(:listing).permit(
        :name, :category_id, :subcategory_id, :city_id,
        :brand, :condition, :location, :description,
        :delivery_time, :delivery_cost, :price,
        :price_per, :salary_per, :price_per_property,
        :car_make, :car_model, :car_reg_year, :car_gearbox, :car_mileage,
        :car_engine_size, :car_fuel_type, :car_body_type, :car_color,
        :job_type, :property_type, :property_size_rooms, :property_size_meters,
        :property_size_feets, :property_date_available, :video_url, :pet_type,
        :pick_up_only, :published, :featured_home, :featured_cat, :urgent,
        :price_open_to_offers, :price_per, :salary_per, :price_per_property,
        :wholesale_price, :retail_price,:sale_price, :wholesale_moq,
        :company_displayed, :company_country, :company_phone, :company_website,
        :company_facebook, :company_twitter, :company_youtube, :company_googleplus,
        :company_instagram, :company_linkedin, :cancellations_and_returns,
        :warranty, :agree_to_terms, :deal_url, :deal_expire_time, :deal_coupon,
        :company_tags => [], :key_features => [], :keywords => [], :opening_hours => [],
        :photos_attributes => [:image, :listing_id, :id, :_destroy],
        payment_methods: [], tags: []
        )
    end

    def correct_user
      @listing = current_user.listings.find_by(slug: params[:id])
      @listing ||= current_user.listings.find_by(id: params[:id])
      if @listing.nil?
        flash[:error] = "You don't have access to this page"
        redirect_to root_url
      end
    end

  def remove_empty_query_params
    require 'addressable/uri'
    original = request.original_url
    parsed = Addressable::URI.parse(original)
    return unless parsed.query_values.present?
    queries_with_values = parsed.query_values.reject { |_k, v| v.blank? }
    if queries_with_values.blank?
      parsed.omit!(:query)
    else parsed.query_values = queries_with_values
    end
    redirect_to parsed.to_s unless parsed.to_s == original
  end

  def define_countries
    @continents = Continent.all
    @countries = @continents.first.countries.order(:name)
    @regions = @countries.first.regions.order(:name)
    @cities = @regions.first.cities.order(:name)
  end
end
