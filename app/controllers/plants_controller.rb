class PlantsController < ApplicationController
  before_action :set_plant, only: %i[show edit update for_temperature_air_rh for_ground_rh metrics]
  before_action :set_attached_devices, only: %i[show for_temperature_air_rh for_ground_rh metrics]
  before_action :set_metrics, only: %i[show metrics]

  def index
    @plants = Plant.all
  end

  def show
    return if @attached_devices.empty?
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

  # Charts endpoints for Chartkick live refresh
  def for_temperature_air_rh
    render json: set_temperature_air_rh
  end

  def for_ground_rh
    render json: set_ground_rh
  end

  def metrics
    render json: {
      temperature_air_rh: render_to_string(
        partial: "temperature_air_rh",
        locals: { temperature_latest: @temperature_latest, air_rh_latest: @air_rh_latest }
      ),
      tank_level: render_to_string(partial: "tank_level", locals: { tank_level_latest: @tank_level_latest }),
      ground_rh: render_to_string(partial: "ground_rh", locals: { ground_rh_latest: @ground_rh_latest })
    }
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

  def set_metrics
    # Get temperature and relative air humidity
    @temperature_air_rh = set_temperature_air_rh
    @temperature_latest = latest_non_nil_from(array: @temperature_air_rh, dataset: 0) if @temperature_air_rh
    @air_rh_latest = latest_non_nil_from(array: @temperature_air_rh, dataset: 1) if @temperature_air_rh

    # Get relative ground humidity
    @ground_rh = set_ground_rh
    @ground_rh_latest = @ground_rh.last[1] if @ground_rh

    # Get latest tank level
    @tank_level_latest = set_latest_tank_level
  end

  def plant_params
    params.require(:plant).permit(:family, :species, :site_id, :description, :device_ids)
  end

  def set_temperature_air_rh
    return unless @attached_devices.where(temperature: true).count.nonzero?

    temperature = { name: "Température (°C)", data: [] }
    air_rh = { name: "Humidité air (%)", data: [] }
    @attached_devices.where(temperature: true).first.device_metrics.last(60).map do |data|
      temperature[:data] << [data.created_at, data.temperature]
    end
    @attached_devices.where(air_rh: true).first.device_metrics.last(60).map do |data|
      air_rh[:data] << [data.created_at, data.air_rh]
    end
    [temperature, air_rh]
  end

  def set_ground_rh
    return unless @attached_devices.where(ground_rh: true).count.nonzero?

    @attached_devices.where(ground_rh: true).first.device_metrics.last(60).map do |data|
      [data.created_at, data.ground_rh]
    end
  end

  def set_latest_tank_level
    return unless @attached_devices.where(tank_level: true).count.nonzero?

    @attached_devices.where(tank_level: true).first.device_metrics.last.tank_level
  end

  def latest_non_nil_from(args = {})
    rejected_nil = args[:array][args[:dataset]][:data].reject do |data|
      data[1].nil?
    end
    return rejected_nil.last[1]
  end
end
