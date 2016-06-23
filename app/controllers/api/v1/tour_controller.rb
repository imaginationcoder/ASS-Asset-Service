class API::V1::TourController < API::BaseController

  #GET /api/v1/tour
  def index
    @tour_prompts = @application.tour_pre_prompts
  end

end
