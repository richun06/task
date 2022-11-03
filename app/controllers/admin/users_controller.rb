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
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notirce: "編集完了"
    else
      redirect_to admin_users_path, notice: "編集に失敗しました"
    end
  end

  def show
    @tasks = current_user.tasks
  end

  def destroy
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

  def set_user
    @user = User.find(params[:id])
  end
end
