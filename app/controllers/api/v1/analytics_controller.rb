class API::V1::AnalyticsController < API::BaseController

  # inserts a document for how much time user spent on tour step or permission
  def time_spent
    template = Template.find(params[:uid])
    app = template.app
    platform = Platform.where(name: /^#{params[:platform]}$/i ).first
    category = platform.platform_categories.where(name: /^#{params[:platform_category]}$/i ).first rescue nil
    timed_analytic = TimedAnalytics.new(app: app, template: template, app_version: app.published_version.number,
                                        platform: platform, platform_category_id: category.try(:id),
                                        event: 'Time Spent', ip_address: params[:ip_address],
                                        time_spent: params[:time_spent])
    if timed_analytic.save
      render status: 200, json: { status: 200, success: true }
    else
      #The Webdav RFC doesn't say 422 means "semantic errors", it says the server was "unable to process the contained instructions"
      render_error_response(422, 'Unable to save', timed_analytic.errors.full_messages.to_sentence)
    end

  end


  def permission_accepted
    template = Template.find(params[:uid])
    app = template.app
    platform = Platform.where(name: /^#{params[:platform]}$/i ).first
    category = platform.platform_categories.where(name: /^#{params[:platform_category]}$/i ).first rescue nil
    accepted_analytic = AcceptedAnalytics.new(app: app, template: template, app_version: app.published_version.number,
                                        platform: platform, platform_category_id: category.try(:id),
                                        event: 'Permission Accepted', ip_address: params[:ip_address],
                                        is_accepted: params[:is_accepted])
    if accepted_analytic.save
      render status: 200, json: { status: 200, success: true }
    else
      #The Webdav RFC doesn't say 422 means "semantic errors", it says the server was "unable to process the contained instructions"
      render_error_response(422, 'Unable to save', accepted_analytic.errors.full_messages.to_sentence)
    end

  end

end