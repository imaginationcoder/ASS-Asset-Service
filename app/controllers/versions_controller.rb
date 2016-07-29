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
    respond_to do |format|
      format.js {  render nothing: true }
      format.html do
        flash[:success] = "Version #{@version.number} published successfully."
        redirect_to versions_path(@app)
      end
    end
  end

  def preview
    @templates = @app.templates.where(app_version: @version.number)
    tour_permission = Permission.tour
    @tour_templates = @templates.where(permission_id: tour_permission.id)
    @permissions = Permission.where(:id.ne=> tour_permission.id)
  end

  private
  def load_app
    @app = App.find(params[:id])
  end

  def load_version
    @version = @app.versions.find(params[:version_id])
  end

end
