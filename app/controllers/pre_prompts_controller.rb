class PrePromptsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_app, only: [:create]

  def new
    @app = App.find(params[:app_id])
    @preference = Preference.find(params[:preference_id])
    @pre_prompt = @app.pre_prompts.build(preference: @preference)
    @pre_prompt.button_actions.build
  end

  def create
    @pre_prompt = @app.pre_prompts.build(pre_prompt_params)
    if @pre_prompt.save
      redirect_to app_url(@app), notice: 'Pre Prompt added to app.'
    else
      render action: "new"
    end
  end

  private
  def find_app
    @app = App.find(params[:pre_prompt][:app_id])
  end

  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def pre_prompt_params
    params.require(:pre_prompt).permit(:app_id, :preference_id, :header, :header_position, :text, :text_position, :source,
                                        button_actions_attributes: [:btn_type, :text, :text_position, :source, :_destroy,:id])
  end
end
