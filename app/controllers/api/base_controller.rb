class API::BaseController < ApplicationController
  before_action :request_must_be_json
  before_action :authenticate_from_client_id_and_secret!
  skip_before_action :verify_authenticity_token

  respond_to :json

  rescue_from Mongoid::Errors::DocumentNotFound do |e|
    render json: { message: e.message, error: 'record not found' }, status: :not_found
  end


  private

  def user_not_authorized
    render status: :unauthorized,#:forbidden
           json: { success: false, error: 'Access Denied'}
  end

  def authenticate_from_client_id_and_secret!
    unless valid_headers?
      render status: 401,  json: {success: false,message: 'clientId,clientSecret are missed in headers',
                                  error: "Not authenticated" }
      return
    end
    @application = Application.where(client_id: client_id_from_headers, secret_token: client_secret_from_headers).first
    if @application
      if @application.expired?
        render(status: 401,  json: {success: false, error: "Application Token expired" })
        return
      else
        # DO other stuff if any related after successful of finding app
        # current_user = @application.user
        return
      end
    end
    render status: 401,  json: {success: false,message: 'Invalid clientId or clientSecret', error: "Not authenticated" }

  end

  def request_must_be_json
    #if request.format != :json
    if request.content_type != 'application/json'
      render status: 406, json: {success: false ,message: 'The request must be json',error: 'Not a valid json request'}
      return
    end
  end

  private
  def valid_headers?
    client_id_from_headers and client_secret_from_headers
  end

  def client_id_from_headers
    request.headers["clientId"]
  end

  def client_secret_from_headers
    request.headers["clientSecret"]
  end


end