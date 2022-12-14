class TasksController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def index
    @tasks = current_user.tasks.page(params[:page]).per(50)

    if params[:sort_expired]
      @tasks = @tasks.order(deadline: :desc)
    elsif params[:sort_priority]
      @tasks = @tasks.order(priority: :asc)
    else
      @tasks = @tasks.order(created_at: :desc)
    end

    if params[:search]
      @tasks = @tasks.title_search(params[:search][:title]).status_search(params[:search][:status]).search_and(params[:search][:title], params[:search][:status])
    end

    if params[:label_id].present?
      @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] })
    end
  end

  def new
    @task = Task.new
    # @labels = current_user.labels
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
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
    params.require(:task).permit(:title, :content, :deadline, :priority, :user_id, { label_ids: [] }).merge(status: params[:task][:status].to_i, priority: params[:task][:priority].to_i)
  end

end
