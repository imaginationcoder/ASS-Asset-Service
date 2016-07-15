module TemplatesHelper

  def add_template_path(app, permission)
    new_app_template_path(app, permission_id: permission)
  end

  # if permission pre-prompt(template) is already added to an app
  # then show the template path else link it to new_template_path
  def sidebar_permission_path(app, permission)
    template = app.find_template(permission)
    template ? template_path(template) : add_template_path(app, permission)
  end

  def sidebar_tour_path(app)
    app.tour_templates.blank? ? new_tour_app_path(app) : tour_app_path(app)
  end

end
