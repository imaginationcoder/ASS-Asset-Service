class ProfileController < ApplicationController
  layout 'adminlte'
  before_action :authenticate_user!

  def index; end

  def update_avatar
    if current_user.update_attributes(avatar_params)
     flash[:success] = 'Avatar changed successfully.'
    else
      flash[:error] = 'Avatar upload failed.'
    end
    redirect_to profile_url
  end


  protected
  def avatar_params
    params.require(:user).permit(:avatar)
  end

end
