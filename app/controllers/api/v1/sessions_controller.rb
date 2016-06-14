class API::V1::SessionsController < API::BaseController
  skip_before_filter :authenticate_developer_app!, only: :authorize_app

  def authorize_app
    unless valid_params?
      render status: 401,  json: {success: false,message: 'client_id and client_secret_token missed in body',
                                  error: "Not authenticated" }
      return
    end
    @application = Application.where(client_id: params[:client_id], secret_token: params[:client_secret_token]).first
    if @application
      if @application.expired?
        render(status: 401,  json: {success: false, error: "Application Token expired" })
        return
      else
        doorkeeper_token.set(resource_owner_id: @application.user.id)
        @application.app_access_tokens.create(access_token: doorkeeper_token.token)
        render status: 200, json: {success: true ,data: {access_token: doorkeeper_token.token}}
        return
      end
    else
      render status: 401,  json: { success: false, message: 'Invalid client_id or client_secret_token or App not found.',
                                   error: "Not authenticated" }
    end

  end


  private
  def valid_params?
    params[:client_id].present? and params[:client_secret_token].present?
  end


end
