class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    # sign_in user
    session[:user_id] = user.id
    redirect_to root_url
    # redirect_to '/timetable/show'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end

