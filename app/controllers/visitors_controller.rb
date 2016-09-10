class VisitorsController < ApplicationController

  def new
    @visitor = Visitor.new
  end

  def create
    @visitor = Visitor.new(visitor_params)
    respond_to do |format|
      if @visitor.save
        format.html { redirect_to root_url}
      else
        format.html { redirect_to root_url}
      end
    end
  end

  private
  def visitor_params
    params.require(:visitor).permit(:email)
  end
end