class SessionsController < ApplicationController
  def new
    redirect_to home_path if logged_in?
  end
  
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: "Login successful"
    else
      flash[:error] = "Email and/or password are not valid."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have been logged out."
  end

end
