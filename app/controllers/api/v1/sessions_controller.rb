class API::V1::SessionsController < API::BaseController
  skip_before_filter :authenticate_developer_app!, only: :authorize_app

  def authorize_app
    unless valid_params?
      render_error_response(401,t('api.messages.unauthorized'),t('api.errors.client_id_secret_miss'))
      return
    end
    @application = Application.where(client_id: params[:client_id], secret_token: params[:client_secret_token]).first
    if @application
      if @application.expired?
        render_error_response(401,t('api.messages.token_expired'),t('api.errors.token_expired'))
        return
      else
        doorkeeper_token.set(resource_owner_id: @application.user.id)
        @application.app_access_tokens.create(access_token: doorkeeper_token.token)
        render status: 200, json: { success: true }
        return
      end
    else
      render_error_response(401,t('api.messages.unauthorized'),t('api.errors.invalid_cleint_secret'))
    end

  end


  private
  def valid_params?
    params[:client_id].present? and params[:client_secret_token].present?
  end


end
