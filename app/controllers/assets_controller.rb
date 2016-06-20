class AssetsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_tour, only: :create

  def create
    @asset = @tour.assets.build(asset_params)
    if @asset.save
      redirect_to tour_path(@tour), notice: 'Asset was successfully uploaded.'
    else
      render action: "tours/show"
    end
  end



  private
  def find_tour
    @tour = Tour.find(params[:tour_id])
    #raise @app.inspect
  end

  def asset_params
    params.require(:asset).permit(:heading,:description,:source)
  end
end
