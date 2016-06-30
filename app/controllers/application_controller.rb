class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  use_growlyflash # except: %i[actions without growlyflash]
 # Also there is another shorthand, to skip callbacks:
 # skip_growlyflash only: %i[actions without growlyflash]


  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || my_apps_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:fname, :lname, :company]
    devise_parameter_sanitizer.for(:account_update) << [:fname, :lname, :company]
  end

  def layout_by_resource
    if devise_controller?
      "home"
    else
      "application"
    end
  end


end
