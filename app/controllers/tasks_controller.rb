class TasksController < ApplicationController

  def index
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

end
