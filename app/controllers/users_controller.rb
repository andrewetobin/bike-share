class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def show
    @user = User.find(current_user.id)
    unless current_user == @user
      redirect_to dashboard_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    render file: '/public/404' unless current_user == @user || current_admin?
  end

  def update
    @user = User.update(user_params)
    flash[:notice] = "Account Updated"
    redirect_to dashboard_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :username, :password, :role)
    end
end
