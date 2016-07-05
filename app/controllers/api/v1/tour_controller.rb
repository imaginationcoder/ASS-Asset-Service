class API::V1::TourController < API::BaseController

  #GET /api/v1/tour
  def index
    @tour_templates = @application.tour_templates
  end

end
