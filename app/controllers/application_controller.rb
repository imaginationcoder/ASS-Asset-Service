class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource
  before_action :fetch_my_apps
  before_action :ensure_signup_complete, except: [:sent_email_instructions,:finish_signup]


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:full_name, :company]
    devise_parameter_sanitizer.for(:account_update) << [:full_name, :company]
  end

  # if user tried to singup via social and email not provided(like twitter etc.)
  def ensure_signup_complete
    return if devise_controller?
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'
    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      flash[:notice] = 'Please confirm your email address before continuing'
      redirect_to finish_signup_path(current_user)
    end
  end

  def layout_by_resource
    if devise_controller?
      "authentication"
    else
      "application"
    end
  end

  def fetch_my_apps
    if current_user
      @my_apps = current_user.apps.order(created_at: :asc)
      @tour_permission = Permission.tour
      @permissions = Permission.nin(name: @tour_permission.name)
    end
  end

  ## private methods
  private
  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || my_apps_path
  end
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end


end
