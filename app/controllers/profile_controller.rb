class ProfileController < ApplicationController
  layout 'adminlte'
  before_action :authenticate_user!

  def index; end

end
