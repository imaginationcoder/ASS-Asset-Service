class AppsController < ApplicationController
  before_action :authenticate_user!

  def index
    @apps = current_user.apps.order(created_at: :desc)
  end

  # GET /apps/new
  def new
    @app = current_user.apps.build
  end

  # POST /apps
  def create
    @app = App.new(app_params)
    @app.platform_ids = [ Platform.first.id ]
    @app.user = current_user
    if @app.save
      redirect_to my_apps_url, notice: 'App was successfully created.'
    else
      render action: "new"
    end
  end

  # GET /apps/1/edit
  def edit
    @app = App.find(params[:id])
  end

  # PUT /apps/1
  def update
    @app = App.find(params[:id])
    if @app.update_attributes(app_params)
      redirect_to my_apps_url, notice: 'App was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /apps/1
  def destroy
    @app = App.find(params[:id])
    @app.destroy
    redirect_to my_apps_url
  end


  private
  def app_params
    params.require(:app).permit(:id, :name, :description, :platform_ids)
  end

end