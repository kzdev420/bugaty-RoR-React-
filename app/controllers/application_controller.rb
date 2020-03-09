class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :create_podcast_host

  $all_cats = Category.all.order(:serial_number, :name)
  $banner = Banner.first
  $template = Template.first
  $price = Price.first
  $email_template = EmailTemplate.first

  # def current_user
  #   super

  #   if current_user.present?
  #     @current_user = User.find_by(current_user.id)
  #     puts "=================== #{@current_user} ================ "
  #   end

  #   # if (user_id = session[:user_id])
  #   #   @current_user ||= User.find_by(id: user_id) if session[:user_id]
  #   # elsif (user_id = cookies.signed[:user_id])
  #   #   user = User.find_by(id: user_id)
  #   #   if user && user.authenticated?(:remember, cookies[:remember_token])
  #   #     log_in user
  #   #     @current_user = user
  #   #   end
  #   # end
  # end

private
  def create_podcast_host
    if PodcastHost.count == 0
      PodcastHost.create(description: 'Podcast Host description')
    end
  end
  # override the devise helper to store the current location so we can
  # redirect to it after loggin in or out. This override makes signing in
  # and signing up work automatically.

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :current_password])
    # devise_parameter_sanitizer.for(:account_update) { |u|
    #   u.permit(:password, :password_confirmation, :current_password)
    # }
  end

end
