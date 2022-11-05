class LabelsController < ApplicationController

  def new
    @label = Label.new
  end

  def index
    @labels = Label.all
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_path
    else
      render :new
    end
  end

  def show
    @label = Label.find(params[:id])
  end

  def edit
    @label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])
  end

  def destroy
    @label = Label.find(params[:id])
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
