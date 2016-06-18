class AppsController < ApplicationController
  before_action :authenticate_user!

  def index
    @apps = current_user.apps
  end

  def new
    @app = current_user.apps.build
  end

end
