class HomeController < ApplicationController
  layout 'home'
  def index
    @visitor = Visitor.new
  end
end
