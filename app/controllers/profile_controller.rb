class ProfileController < ApplicationController
  layout 'adminlte'
  before_action :authenticate_user!

  def index; end

  def update_avatar
    if current_user.update_attributes(avatar_params)
     flash[:success] = 'Avatar changed successfully.'
     redirect_to profile_url
    else
      render 'index'
    end
  end

  # update profile
  def update
    if current_user.update_attributes(profile_params)
      flash[:success] = 'Profile updated successfully.'
      redirect_to profile_url
    else
      render 'index'
    end

  end


  protected
  def avatar_params
    params.require(:user).permit(:avatar)
  end

  def profile_params
    params.require(:user).permit(:fname,:lname,:email,:phone,:company,:designation,:notes)
  end

end
