class PlantsController < ApplicationController
  before_action :set_plant, only: :show

  def index
    @plants = Plant.all
  end

  def show
    attached_devices = @plant.devices
    temperatures = { name: "Temperatures (°C)", data: [] }
    air_rh = { name: "Air humidity (%)", data: [] }
    attached_devices.where(temperature: true).first.device_metrics.map do |data|
      temperatures[:data] << [data.created_at, data.temperature]
    end
    attached_devices.where(temperature: true).first.device_metrics.map do |data|
      air_rh[:data] << [data.created_at, data.air_rh]
    end
    @data = [temperatures, air_rh]
  end

  def new
    @plant = Plant.new
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
    @plant = Plant.find(params[:id])
  end

  def plant_params
    params.require(:plant).permit(:family, :species, :site_name, :description)
  end
end
