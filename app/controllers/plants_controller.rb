class PlantsController < ApplicationController
  before_action :set_plant, only: %i[show edit update]
  before_action :set_attached_devices, only: :show

  def index
    @plants = Plant.all
  end

  def show
    return if @attached_devices.empty?

    # Get temperature and relative air humidity
    @temperature_air_rh = set_temperature_air_rh
    @temperature_latest = get_latest_data_from(array: @temperature_air_rh, item: 0).round if @temperature_air_rh
    @air_rh_latest = get_latest_data_from(array: @temperature_air_rh, item: 1).round if @temperature_air_rh

    # Get relative ground humidity
    @ground_rh = set_ground_rh
    @ground_rh_latest = @ground_rh.last[1].round if @ground_rh

    # Get latest tank level
    @tank_level_latest = set_latest_tank_level
  end

  def new
    @plant = Plant.new
    @devices = Device.all
  end

  def create
    @plant = Plant.new(plant_params)
    if @plant.save
      attach_devices
      redirect_to plant_path(@plant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @plant.update(plant_params)
    redirect_to plant_path(@plant)
  end

  private

  def set_plant
    @plant = Plant.find(params[:id])
  end

  def attach_devices
    params[:plant][:device_ids][(1..)].each do |device|
      PlantDevice.create(plant_id: @plant.id,
                         device_id: device)
    end
  end

  def set_attached_devices
    @attached_devices = @plant.devices.empty? ? [] : @plant.devices
  end

  def plant_params
    params.require(:plant).permit(:family, :species, :site_id, :description, :device_ids)
  end

  def set_temperature_air_rh
    return unless @attached_devices.where(temperature: true).count.nonzero?

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
    return unless @attached_devices.where(ground_rh: true).count.nonzero?

    @attached_devices.where(ground_rh: true).first.device_metrics.map do |data|
      [data.created_at, data.ground_rh]
    end
  end

  def set_latest_tank_level
    return unless @attached_devices.where(tank_level: true).count.nonzero?

    @attached_devices.where(tank_level: true).first.device_metrics.last.tank_level
  end

  def get_latest_data_from(args = {})
    args[:array][args[:item]][:data].last[1]
  end
end
