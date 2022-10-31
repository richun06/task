class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    redirect_to user_path(session[:user_id]) if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    redirect_to tasks_path unless params[:id] == current_user.id
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
