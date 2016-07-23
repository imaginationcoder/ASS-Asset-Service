class API::V1::TourController < API::BaseController

  #GET /api/v1/tour
  def index
    @tour_templates = @application.published_tour_templates
  end

end
