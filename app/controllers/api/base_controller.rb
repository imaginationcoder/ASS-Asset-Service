class API::BaseController < ApplicationController

  before_action :request_must_be_json
  before_action :doorkeeper_authorize!
  before_action :authenticate_app!
  skip_before_action :verify_authenticity_token

  respond_to :json
  #respond_to :xml, only: []

  rescue_from Mongoid::Errors::DocumentNotFound do |e|
    render json: { message: e.message, error: 'record not found' }, status: :not_found
  end

  private

  def doorkeeper_unauthorized_render_options(error: nil)
    {:json => {:status=> "401", :message=> "Application authentication failed."}}
  end

  def user_not_authorized
    render status: :unauthorized,#:forbidden
           json: { success: false, error: 'Access Denied'}
  end

  def authenticate_app!
    app_access_token = AppAccessToken.where(access_token: doorkeeper_token.token).first
    if app_access_token
      @application = app_access_token.application
      sign_in @application.user, store: false
      return
    else
      render status: 401,  json: { success: false, message: 'App not found with given access_token.Please authorize the app with clientId and secret', error: "Not authenticated" }
      return
    end
  end

  def request_must_be_json
    #if request.format != :json
    if request.content_type != 'application/json'
      render status: 406, json: { success: false, message: 'The request must be json', error: 'Not a valid json request'}
      return
    end
  end



end