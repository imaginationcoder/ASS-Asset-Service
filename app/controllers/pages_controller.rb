# any other pages not related to dashboard
class PagesController < ApplicationController
  layout 'authentication'
  before_action :authenticate_user!, except: [:sent_email_instructions]


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
  def finish_signup_params
    accessible = [ :full_name, :email ] # extend with your own params
    accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end

end