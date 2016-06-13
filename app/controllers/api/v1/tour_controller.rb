class API::V1::TourController < API::BaseController

  #GET /api/v1/tour
  def index
    @tour = @application.tour
  end

end
