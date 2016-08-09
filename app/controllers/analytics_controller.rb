class AnalyticsController < ApplicationController
  layout 'adminlte'
  before_action :authenticate_user!
  before_action :load_app

  def index
    @version = params[:version] || @app.published_version.try(:number) || @app.editing_version.number
    @templates = @app.templates.where(app_version: @version)
    tour_permission = Permission.tour
    @tour_templates = @templates.where(permission_id: tour_permission.id)
    @permission_templates = @templates.where(:permission_id.ne=> tour_permission.id)
  end

  private
  def load_app
    @app = App.find(params[:id])
  end

end
