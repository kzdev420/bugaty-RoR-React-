class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # def facebook
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end

  # def failure
  #   redirect_to root_path
  # end

  # def google_oauth2
  #     # You need to implement the method below in your model (e.g. app/models/user.rb)
  #     @user = User.from_omniauth(request.env["omniauth.auth"])

  #     if @user.persisted?
  #       flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
  #       sign_in_and_redirect @user, :event => :authentication
  #     else
  #       session["devise.google_data"] = request.env["omniauth.auth"]
  #       redirect_to new_user_registration_url
  #     end
  # end


  # def self.from_omniauth(access_token)
  #     data = access_token.info
  #     user = User.where(:email => data["email"]).first

  #     # Uncomment the section below if you want users to be created if they don't exist
  #     # unless user
  #     #     user = User.create(name: data["name"],
  #     #        email: data["email"],
  #     #        password: Devise.friendly_token[0,20]
  #     #     )
  #     # end
  #     user
  # end

  def facebook
    generic_callback( 'facebook' )
  end

  def google_oauth2
    generic_callback( 'google_oauth2' )
  end

  def generic_callback( provider )
    @identity = Identity.find_for_oauth env["omniauth.auth"]

    @user = @identity.user || current_user

    if @user.nil?
      @user = User.from_omniauth(env["omniauth.auth"])
      @identity.update_attribute( :user_id, @user.id )
      sign_in @user
    end

    if @user.email.blank? && @identity.email
      @user.update_attribute( :email, @identity.email)
    end

    if @user.persisted?
      @identity.update_attribute( :user_id, @user.id )
      # This is because we've created the user manually, and Device expects a
      # FormUser class (with the validations)
      #@user = FormUser.find @user.id
      @user = User.friendly.find @user.id
      if session[:redirect_to].present?
        sign_in @user
        redirect_to session[:redirect_to]
      else
        sign_in_and_redirect @user, event: :authentication
      end
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def upgrade
    scope = nil
    if params[:provider] == "google_oauth2"
      scope = "email,profile,offline,https://www.googleapis.com/auth/admin.directory.user"
    end

    if params[:provider] == "facebook"
      # redirect_to user_omniauth_authorize_path( params[:provider] ), flash: { scope: scope }
      redirect_to user_facebook_omniauth_authorize_path, flash: { scope: scope }
    elsif params[:provider] == "google_oauth2"
      redirect_to user_google_oauth2_omniauth_authorize_path, flash: { scope: scope }
    end

  end

  def setup
    request.env['omniauth.strategy'].options['scope'] = flash[:scope] || request.env['omniauth.strategy'].options['scope']
    render :text => "Setup complete.", :status => 404
  end

end
