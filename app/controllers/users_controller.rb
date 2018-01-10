class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to sign_in_path, notice: "You are registered."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Your profile was updated."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end

  def set_user
    @user = User.find_by(params[:id])
  end
  
end
