class TasksController < ApplicationController

  def index
    @tasks = Task.all

    if params[:sort_expired]
      @tasks = @tasks.order(deadline: :desc)
    else
      @tasks = @tasks.order(created_at: :desc)
    end

    if params[:search]
      @tasks = @tasks.title_search(params[:search][:title]).status_search(params[:search][:status])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    # byebug
    if @task.save
      redirect_to tasks_path, notice: "タスク登録完了！"
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集完了！"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "削除完了"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline).merge(status: params[:task][:status].to_i)
  end

end
