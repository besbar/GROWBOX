class PlantsController < ApplicationController
  before_action :set_plant, only: %i[new]

  def index
    @plants = Plant.all
  end

  def show
    @plant = Plant.find(params[:id])
  end

  def new
  end

  def create
    @plant = Plant.new(plant_params)
    @plant.user = current_user
    if @plant.save
      redirect_to plant_path(@plant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_plant
    @plant = Plant.new
  end

  def plant_params
    params.require(:plant).permit(:family, :species, :site_name, :description)
  end
end
