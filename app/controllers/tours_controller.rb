class ToursController < ApplicationController
  before_action :authenticate_user!
  before_action :find_app

  def create
    @tour = @app.build_tour(tour_params)
    if @tour.save
      redirect_to my_apps_url, notice: 'Tour was successfully created.'
    else
      render action: "new"
    end
  end


  private
  def find_app
    @app = App.find(params[:tour][:app_id])
    #raise @app.inspect
  end

  def tour_params
    params.require(:tour).permit(:name, :app_id)
  end

end
