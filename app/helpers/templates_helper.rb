module TemplatesHelper

  def add_template_path(app, permission)
    new_app_template_path(app, permission_id: permission)
  end

end
