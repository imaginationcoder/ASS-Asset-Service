class GuidesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_tour#, only: :create

  def create
    @guide = @tour.guides.build(asset_params)
    if @guide.save
      redirect_to tour_path(@tour), notice: 'Asset was successfully uploaded.'
    else
      render action: "tours/show"
    end
  end

 def destroy
   guide = @tour.guides.find(params[:id])
   guide.destroy
   redirect_to tour_path(@tour), notice: 'Asset was successfully deleted.'
 end

  private
  def find_tour
    @tour = Tour.find(params[:tour_id])
  end

  def asset_params
    params.require(:guide).permit(:heading,:description,:source)
  end
end
