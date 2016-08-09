class ProfileController < ApplicationController
  layout 'adminlte'
  layout 'authentication' , only: [:finish_signup,:sent_email_instructions]
  before_action :authenticate_user!, except: [:sent_email_instructions]

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

  def finish_signup
    if request.patch? && params[:user] #&& params[:user][:email]
      if current_user.update(finish_signup_params)
        #current_user.skip_reconfirmation!
        #sign_in(current_user, :bypass => true)
        redirect_to sent_email_instructions_path, notice: t('devise.confirmations.send_instructions')
      else
        @show_errors = true
      end
    end
  end

  protected
  def avatar_params
    params.require(:user).permit(:avatar)
  end

  def profile_params
    params.require(:user).permit(:full_name,:email,:phone,:company,:notes)
  end

  def password_params
    params.require(:user).permit(:current_password,:password,:password_confirmation)
  end

  def finish_signup_params
    accessible = [ :full_name, :email ] # extend with your own params
    accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end

end
