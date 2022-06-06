class PlantsController < ApplicationController
  before_action :set_plant, only: %i[show edit update]
  before_action :set_attached_devices, only: :show

  def index
    @plants = Plant.all
    @markers = @plants.geocoded.map do |plant|
      {
        lat: plant.latitude,
        lng: plant.longitude
        info_window: render_to_string(partial: "info_window", locals: {plant: plant})
      }
    end
  end

  def show
    return if @attached_devices.empty?

    # Get temperature and relative air humidity
    @temperature_air_rh = set_temperature_air_rh
    @temperature_latest = get_latest_data_from(array: @temperature_air_rh, item: 0).round
    @air_rh_latest = get_latest_data_from(array: @temperature_air_rh, item: 1).round

    # Get relative ground humidity
    @ground_rh = set_ground_rh
    @ground_rh_latest = @ground_rh.last[1].round

    # Get latest tank level
    @tank_level_latest = set_latest_tank_level
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(plant_params)
    @plant.user = current_user
    @plant.address = Plant::SITE_NAME_ADDRESS[Plant::SITE_NAME.find_index(plant_params[:site_name])]
    if @plant.save
      redirect_to plant_path(@plant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @plant.update(plant_params)
    @plant.update({address: Plant::SITE_NAME_ADDRESS[Plant::SITE_NAME.find_index(plant_params[:site_name])]})
    redirect_to plant_path(@plant)
  end

  private

  def set_plant
    @plant = Plant.find(params[:id])
  end

  def set_attached_devices
    @attached_devices = @plant.devices.empty? ? [] : @plant.devices
  end

  def plant_params
    params.require(:plant).permit(:family, :species, :site_name, :description)
  end

  def set_temperature_air_rh
    temperature = { name: "Température (°C)", data: [] }
    air_rh = { name: "Humidité air (%)", data: [] }
    @attached_devices.where(temperature: true).first.device_metrics.map do |data|
      temperature[:data] << [data.created_at, data.temperature]
    end
    @attached_devices.where(air_rh: true).first.device_metrics.map do |data|
      air_rh[:data] << [data.created_at, data.air_rh]
    end
    [temperature, air_rh]
  end

  def set_ground_rh
    @attached_devices.where(ground_rh: true).first.device_metrics.map do |data|
      [data.created_at, data.ground_rh]
    end
  end

  def set_latest_tank_level
    @attached_devices.where(tank_level: true).first.device_metrics.last.tank_level
  end

  def get_latest_data_from(args = {})
    args[:array][args[:item]][:data].last[1]
  end
end
