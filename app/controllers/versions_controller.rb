class VersionsController < ApplicationController
  layout 'adminlte'
  before_action :authenticate_user!
  before_action :load_app
  before_action :load_version, except: :index

  def index
    @versions = @app.versions.order_by(number: :desc)
    @published_version = @app.published_version
  end

  def publish
    @version.update(published: true)
    #flash[:notice] = "Version #{@version.number} published successfully."
    render nothing: true
  end

  def preview
    templates = @app.templates.where(app_version: @version.number)
    @tour_templates = templates.where(permission_id: Permission.tour.id)
    @permission_templates =  templates.where(:permission_id.ne=> Permission.tour.id)
  end

  private
  def load_app
    @app = App.find(params[:id])
  end

  def load_version
    @version = @app.versions.find(params[:version_id])
  end

end
