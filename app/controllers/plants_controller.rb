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

  private

  def set_plant
    @plant = Plant.new
  end
end
