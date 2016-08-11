class API::V1::PermissionsController < API::BaseController

  #/api/v1/permission/:name/assets
  def index
    # find permission with case insensitive
    permission = Permission.where(name: /^#{params[:name]}$/i ).first
    if permission
      @template = @application.find_published_template(permission)
      render_error_response(404,"#{params[:name]} permission assets not yet added, please add from dashboard",'Assets Not found') unless @template
    else
      render_error_response(404,"#{params[:name]} permission doesn't find in our records",'Not found')
    end
  end

end