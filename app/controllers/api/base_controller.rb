class API::BaseController < ActionController::Base
  include Utilities::ErrorHandling

  before_action :request_must_be_json
  before_action :doorkeeper_authorize!
  before_action :authenticate_developer_app!
  skip_before_action :verify_authenticity_token

  respond_to :json
  #respond_to :xml, only: []

  rescue_from Mongoid::Errors::DocumentNotFound do |e|
    render_error_response(:not_found, 'record not found', e.message)
  end

  rescue_from ActionController::ParameterMissing do |e|
    render_error_response(:not_found, 'missed some parameters', e.message)
  end


  private

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: {status: 401, message: t('api.messages.authentication_fail')}}
  end

  def user_not_authorized
    render_error_response(401, t('api.messages.unauthorized'), t('api.errors.unauthorized'))
  end

  def authenticate_developer_app!
    app_access_token = AppAccessToken.where(access_token: doorkeeper_token.token).first
    if app_access_token
      @application = app_access_token.app
      sign_in @application.user, store: false
    else
      render_error_response(401, t('api.messages.app_not_found'), t('api.errors.unauthorized'))
    end
  end

  def request_must_be_json
    #if request.format != :json
    if request.content_type != 'application/json'
      render_error_response(406, t('api.messages.must_be_json'),t('api.errors.must_be_json'))
    end
  end



end