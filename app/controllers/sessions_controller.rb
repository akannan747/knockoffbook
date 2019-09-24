class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_user_name(params[:user_name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "You have been successfully logged in!"
    else
      flash[:alert] = "You have entered an invalid username or password. Please try again."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have been successfully logged out!"
  end
end
