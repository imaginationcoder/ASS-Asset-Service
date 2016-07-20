class VersionsController < ApplicationController
  layout 'adminlte'
  before_action :load_app


  def index
    @versions = @app.versions.order_by(number: :desc)
    @published_version = @app.published_version
  end

  def publish
    @version = @app.versions.find(params[:version_id])
    @version.update(published: true)
    redirect_to versions_url(@app) , notice: "Version #{@version.number} published successfuly."
  end


  private
  def load_app
    @app = App.find(params[:id])
  end

end
