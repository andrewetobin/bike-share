class UsersController < ApplicationController
  before_action :require_user, only: [:show, :edit]

  def show
    if current_admin?
      @user = User.find(params[:id])
    elsif current_user
      @user = User.find(current_user.id)
    else
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
    if current_admin?
      @user = User.find(params[:id])
    elsif current_user
      @user = User.find(current_user.id)
    else
      render file: '/public/404'
    end
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
