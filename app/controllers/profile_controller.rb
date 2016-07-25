class ProfileController < ApplicationController
  layout 'adminlte'
  before_action :authenticate_user!

  def index; end

  def update_avatar
    if current_user.update(avatar_params)
     flash[:success] = 'Avatar changed successfully.'
     redirect_to profile_url
    else
      render 'index'
    end
  end

  # update profile
  def update
    if current_user.update(profile_params)
      flash[:success] = 'Profile updated successfully.'
      redirect_to profile_url
    else
      render 'index'
    end
  end

  # update password
  def update_password
    @user = current_user
    #To use "confirm_password" field to force user to enter old password before updating with the new one:
    # Change @user.update(user_params) to @user.update_with_password(user_params)
    if @user.update_with_password(password_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @user, bypass: true
      flash[:success] = 'Password updated successfully.'
    end

  end

  protected
  def avatar_params
    params.require(:user).permit(:avatar)
  end

  def profile_params
    params.require(:user).permit(:fname,:lname,:email,:phone,:company,:designation,:notes)
  end

  def password_params
    params.require(:user).permit(:current_password,:password,:password_confirmation)
  end

end
