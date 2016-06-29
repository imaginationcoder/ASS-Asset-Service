module PrePromptsHelper

  def add_pre_prompt_path(app, permission)
    new_app_pre_prompt_path(app, permission_id: permission)
  end
end
