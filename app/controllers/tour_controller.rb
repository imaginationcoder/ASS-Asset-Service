class TourController < ApplicationController
  layout 'adminlte'
  before_action :authenticate_user!

  def index
    @app = App.find(params[:id])
    @templates = @app.tour_templates
  end

  def new
    @app = App.find(params[:id])
    @platform = Platform.default
    @platform_categories = @platform.platform_categories
    @template = @app.templates.build
    @text_assets = @template.text_assets.build
    @button_actions = @template.button_actions.build
    @permission = Permission.tour
  end

  def create
    @app = App.find(params[:id])
    if @app.update_attributes(app_params)
      redirect_to tour_app_url(@app), notice: 'Tour was successfully updated.'
    else
      render action: 'new'
    end
  end

  def edit
    @app = App.find(params[:id])
    @platform = Platform.default
    @platform_categories = @platform.platform_categories
    @permission = Permission.tour
    @templates = @app.tour_templates
  end

  def update
    @app = App.find(params[:id])
    if @app.update_attributes(app_params)
      redirect_to tour_app_url(@app), notice: 'Tour was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def app_params
    params.require(:app).permit(:id, :_destroy,
                                templates_attributes: [
                                    :id, :_destroy,:app_id, :permission_id, :platform_id,:platform_category_id,:source,
                                    text_assets_attributes: [:text, :position, :_destroy,:id],
                                    button_actions_attributes: [:btn_type, :label, :target_event, :source, :_destroy,:id]
                                ])
  end
end
