class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  prepend_before_filter :require_no_authentication, :only => [ :new, :create, :cancel ]

  respond_to :html, :json

  # GET /resource/sign_in
  def new
    @page = Page.friendly.find('log-in')
    super
  end

  # POST /resource/sign_in
  # def create

  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  # prepend_before_filter :allow_params_authentication!, :only => :create
  # prepend_before_filter { request.env["devise.skip_timeout"] = true }

  # prepend_view_path 'app/views/devise'

  # # GET /resource/sign_in
  # def new
  #   self.resource = resource_class.new(sign_in_params)
  #   clean_up_passwords(resource)
  #   respond_with(resource, serialize_options(resource))
  # end

  # # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_to do |format|
        format.json { render :json => {}, :status => :ok }
        # format.html { respond_with resource, :location => after_sign_in_path_for(resource) }
        format.html {
          redirect_to stored_location_for(:user) || root_path
        }
    end
  ensure
    Rails.logger.info "\nFAILED_LOGIN ip: #{request.ip}\n" if self.resource.nil?
  end

  # # DELETE /resource/sign_out
  # def destroy
  #   redirect_path = after_sign_out_path_for(resource_name)
  #   signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
  #   set_flash_message :notice, :signed_out if signed_out && is_navigational_format?

  #   # We actually need to hardcode this as Rails default responder doesn't
  #   # support returning empty response on GET request
  #   respond_to do |format|
  #     format.all { head :no_content }
  #     format.any(*navigational_formats) { redirect_to redirect_path }
  #   end
  # end


  # protected

  # def sign_in_params
  #   devise_parameter_sanitizer.sanitize(:sign_in)
  # end

  # def serialize_options(resource)
  #   methods = resource_class.authentication_keys.dup
  #   methods = methods.keys if methods.is_a?(Hash)
  #   methods << :password if resource.respond_to?(:password)
  #   { :methods => methods, :only => [:password] }
  # end

  # def auth_options
  #   { :scope => resource_name, :recall => "#{controller_path}#new" }
  # end

  # def create
  #   respond_to :html, :json
  #   puts "========= PROCESSED BY CUSTOM CONTROLLER ========="
  #   resource = warden.authenticate!(:scope => resource_name, :recall => '#{controller_path}#failure')
  #   sign_in(resource_name, resource)
  #   redirect_to stored_location_for(:user) || root_path
  # end

  # def create
  #   resource = User.find_for_database_authentication(email: params[:user][:email])
  #   return invalid_login_attempt unless resource

  #   if resource.valid_password?(params[:user][:password])
  #     sign_in :user, resource
  #     return render nothing: true
  #   end

  #   invalid_login_attempt
  # end

  # protected

  # def invalid_login_attempt
  #   set_flash_message(:alert, :invalid)
  #   render json: flash[:alert], status: 401
  # end

  # def sign_in_and_redirect(resource_or_scope, resource=nil)
  #   scope = Devise::Mapping.find_scope!(resource_or_scope)
  #   resource ||= resource_or_scope
  #   sign_in(scope, resource) unless warden.user(scope) == resource
  #   return render :json => {:success => true}
  # end

  # def failure
  #   return render :json => {:success => false, :errors => ["Login failed."]}
  # end

end
