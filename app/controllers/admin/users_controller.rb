class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def new
    @user = User.new
  end

  def index
    @users = User.all.includes(:tasks)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザ登録しました"
    else
      render :new_admin
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notirce: "編集完了"
    else
      redirect_to admin_users_path, notice: "編集に失敗しました"
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def if_not_admin
    redirect_to tasks_path, notice: "管理者以外はアクセスできない" unless current_user.admin == true
    # flash[:notice] = "管理者以外はアクセスできない"
  end
end
