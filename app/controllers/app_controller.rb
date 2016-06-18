class AppController < ApplicationController
  before_action :authenticate_user!

  def index
    @apps = current_user.applications
  end

end
