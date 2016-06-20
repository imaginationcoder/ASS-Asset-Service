class ToursController < ApplicationController
  before_action :authenticate_user!
  before_action :find_app, only: :create

  def create
    @tour = @app.build_tour(tour_params)
    if @tour.save
      redirect_to tour_url(@tour), notice: 'Tour was successfully created.'
    else
      render action: "new"
    end
  end

  def show
    @tour = Tour.find(params[:id])
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
