class AnalyticsController < ApplicationController
  layout 'adminlte'
  before_action :authenticate_user!
  before_action :load_app

  def index

  end

  private
  def load_app
    @app = App.find(params[:id])
  end

end
