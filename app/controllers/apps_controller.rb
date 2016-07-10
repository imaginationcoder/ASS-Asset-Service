class AppsController < ApplicationController
  before_action :authenticate_user!
  layout 'adminlte'

  def index

  end

  # GET /apps/new
  def new
    @app = current_user.apps.build
    @default_platform = Platform.default
  end

  # POST /apps
  def create
    @app = App.new(app_params)
    @app.user = current_user
    if @app.save
      flash[:success] = 'App was successfully created.Upload Assets'
      redirect_to app_url(@app)
    else
      @default_platform = Platform.default
      flash.now[:error] = 'Fix the errors'
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
      redirect_to app_url(@app), notice: 'App was successfully updated.'
    else
      render action: "edit"
    end
  end

  def show
    #TODO work on eager loading of prePrompts while looping over through each permission
    @app = App.includes(:templates).find(params[:id]) # eager loaded pre_prompts
  end

  # DELETE /apps/1
  def destroy
    @app = App.find(params[:id])
    @app.destroy
    redirect_to my_apps_url, notice: 'App was successfully deleted.'
  end


  private
  def app_params
    params.require(:app).permit(:logo, :name, :description, :platform_id)
  end

end