class AppsController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_apps = current_user.apps.order(created_at: :desc)
    @tour_permission = Permission.tour
    @permissions = Permission.nin(name: @tour_permission.name)
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
      redirect_to my_apps_url, notice: 'App was successfully updated.'
    else
      render action: "edit"
    end
  end

  def show
    #TODO work on eager loading of prePrompts while looping over through each permission
    @app = App.includes(:pre_prompts).find(params[:id]) # eager loaded pre_prompts
    @tour_permission = Permission.tour
    @tour_prompts = @app.pre_prompts.by_permission(@tour_permission)
    @permissions = Permission.nin(id: @tour_permission.id) # other permissions
  end

  # DELETE /apps/1
  def destroy
    @app = App.find(params[:id])
    @app.destroy
    redirect_to my_apps_url, notice: 'App was successfully deleted.'
  end


  private
  def app_params
    params.require(:app).permit(:id, :name, :description, :platform_id, :platform_category_id,
                                :sw_version, :is_sandbox_mode)
  end

end