class AnalyticsController < ApplicationController
  layout 'adminlte'
  before_action :authenticate_user!
  before_action :load_app

  def index
    @version = params[:version] || @app.published_version.try(:number) || @app.editing_version.number
    @templates = @app.templates.where(app_version: @version)
    tour_permission = Permission.tour
    @tour_templates = @templates.where(permission_id: tour_permission.id)
    @permission_templates = @templates.where(:permission_id.ne=> tour_permission.id)
    @pie_data , @bar_data,@bar_labels = [], [], []
    #fill pie chart data
    colors = %w(#dd4b39 #f39c12 #3c8dbc #00a65a)
    @tour_templates.each_with_index do |template, index|
     @pie_data << {value: template.average_time_spent(@version), color: colors[index],highlight: colors[index],label: "Step#{index + 1}"}
    end
    @permission_templates.each do |template|
      @bar_labels <<  template.permission.name
      @bar_data << template.average_time_spent(@version)
    end

  end

  private
  def load_app
    @app = App.find(params[:id])
  end

end
