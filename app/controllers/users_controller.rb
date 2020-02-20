class UsersController < InheritedResources::Base

	before_action :authenticate_user!, only: [:new, :edit, :update]
	before_action :correct_user, only: [:edit, :destroy, :user_listings]

  def favorite
    @user = find_user
    @listings = current_user.favorites.order('created_at DESC').page(params[:page]).per_page(10)
  end

  def user_listings
    @user = find_user
    if @user == current_user
      if params[:pagination_select].present?
        @listings = Listing.where(user_id: @user.id).order('created_at DESC').page(params[:page]).per_page(params[:pagination_select].to_i)
      else
        @listings = Listing.where(user_id: @user.id).page(params[:page]).per_page(10)
      end
    else
      if params[:pagination_select].present?
        @listings = Listing.where(user_id: @user.id, published: 2).order('created_at DESC').page(params[:page]).per_page(params[:pagination_select].to_i)
      else
        @listings = Listing.where(user_id: @user.id, published: 2).page(params[:page]).per_page(10)
      end
    end

  end

  def show
    @user = find_user

    @user_ads = Listing.active.where(user_id: @user.id, published: 2)
    @user_services = Listing.active.where(user_id: @user.id, category_id: 4, published: 2)
    @user_jobs = Listing.active.where(user_id: @user.id, category_id: 5, published: 2)
    @user_content = @user.listings.active.where(category_id: 25, published: 2)

    @identity_fb = @user.identities.where(provider: 'facebook')
    @identity_g = @user.identities.where(provider: 'google_oauth2')
  end

  def edit
    @user = find_user

    @identity_fb = @user.identities.where(provider: 'facebook')
    @identity_g = @user.identities.where(provider: 'google_oauth2')
  end

  def update
    @user = find_user

    if @user == current_user && @user.update_attributes(user_params)
      flash[:success] = "Your profile was successfully updated."
      redirect_to user_path(@user)
    else
      flash[:error] = "An error occurs while updating your profile. Please try again"
      redirect_to :back
    end
  end

  def set_email_preferences
    @user = User.find_by(slug: params[:id]) || User.find_by(id: params[:id])
    respond_to :json

    if @user.present?
      @user.update_attributes(receive_new_companies: to_boolean(params[:receive_new_companies]))
      @user.update_attributes(receive_new_ads: to_boolean(params[:receive_new_ads]))
      @user.update_attributes(receive_updates: to_boolean(params[:receive_updates]))
      render json: nil, status: :ok
    else
      render json: nil, status: 422
    end
  end

  def upload_cv
    @user = User.friendly.find(params[:id])
    @user.update_attributes(cv: params[:cv])
    if @user.save
      flash[:sucess] = "Your CV was saved."
      redirect_to user_path(@user)
    else
      flash[:error] = "Your CV was not save. Please try again"
      redirect_to :back
    end
  end

  def user_message
    @user = find_user
    if current_user
      @sender = current_user.email
    else
      @sender = params[:sender_email]
    end

    respond_to :json

    if verify_recaptcha
      @result=SendMessageMailer.new_user_user_email(@user, params[:message], @sender).deliver_now
      puts @result.inspect
      render json: nil, status: :ok
    else
      render json: nil, status: 422
    end

  end

  private

    def to_boolean(str)
      str == 'true'
    end

    def correct_user
      @user = find_user
      if @user == current_user

      else
        flash[:error] = "You don't have an acess to this page"
        redirect_to root_url
      end
    end

    def find_user
      User.friendly.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :phone, :language, :location, :last_active, :profile_photo, :cover_photo, :description, :receive_new_companies, :receive_new_ads, :receive_updates, :cv)
    end
end
