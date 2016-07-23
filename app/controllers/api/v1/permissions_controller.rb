class API::V1::PermissionsController < API::BaseController

  #/api/v1/permission/:name/assets
  def index
    # find permission with case insensitive
    permission = Permission.where(name: /^#{params[:name]}$/i ).first
    if permission
      @template = @application.find_published_template(permission)
      render_error_response(404,'Assets Not found',"#{params[:name]} permission assets not yet added, please add from dashboard") unless @template
    else
      render_error_response(404,'Not found',"#{params[:name]} permission doesn't find in our records")
    end
  end

end