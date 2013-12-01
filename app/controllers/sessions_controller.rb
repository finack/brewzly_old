class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    flash.notice = "Welcome #{current_user.name}"
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    flash.notice = "You have successfully logged out."
    redirect_to root_url
  end

end
