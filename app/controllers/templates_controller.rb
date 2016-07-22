class TemplatesController < ApplicationController
  layout 'adminlte'
  before_action :authenticate_user!
  before_action :find_app, only: [:create]

  def show
    @template = Template.find(params[:id])
    @permission = @template.permission
  end

  def new
    @app = App.find(params[:app_id])
    @permission = Permission.find(params[:permission_id])
    @template = @app.templates.build(permission: @permission)
    @template.text_assets.build
    @template.button_actions.build
    @platform = Platform.default
    @platform_categories = @platform.platform_categories
  end

  def edit
    @template = Template.find(params[:id])
    @permission = @template.permission
    @app = @template.app
    @template.text_assets.build
    @template.button_actions.build
    @platform = Platform.default
    @platform_categories = @platform.platform_categories
  end

  def create
    @template = @app.templates.build(template_params)
    if @template.save
      redirect_to template_url(@template), notice: 'Pre Prompt added to app.'
    else
      render action: 'new'
    end
  end

  # PUT /templates/:id
  def update
    @template = Template.find(params[:id])
    if @template.update_attributes(template_params)
      redirect_to template_url(@template), notice: 'Pre Prompt was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /apps/1
  def destroy
    @template = Template.find(params[:id])
    @template.destroy
    redirect_to app_url(@template.app), notice: 'Pre Prompt was successfully deleted.'
  end

  private
  def find_app
    @app = App.find(params[:template][:app_id])
  end

  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def template_params
    params.require(:template).permit(:app_id, :permission_id, :platform_id,:platform_category_id,:source,:_destroy,:id,
                                     text_assets_attributes: [:text, :position, :_destroy,:id],
                                     button_actions_attributes: [:btn_type, :label, :target_event, :source, :_destroy,:id])
  end
end
