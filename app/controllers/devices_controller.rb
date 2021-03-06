class DevicesController < ApplicationController
  before_action :set_device, only: :show

  def index
    @devices = Device.all
  end

  def show
    @attached_plants = @device.plants
    @attached_alerts = @device.alert_settings
  end

  def new
    @device = Device.new
  end

  def create
    sensor_hash = { humidité_sol: { ground_rh: true },
                    débitmètre: { volume: true },
                    luminosité: { luminosity: true },
                    réservoir: { tank_level: true },
                    environnement: { temperature: true, air_rh: true } }
    parameters = ["temperature", "air_rh", "ground_rh", "luminosity", "volume", "tank_level"]

    @device = Device.new(device_params)

    if device_params[:subcategory].empty? || device_params[:category].empty?
      render :new, status: :unprocessable_entity
    else
      subcategory = device_params[:subcategory].gsub(" ", "_").to_sym
      parameters.each do |param|
        if sensor_hash[subcategory][param.to_sym]
          @device.public_send(:"#{param}=", sensor_hash[subcategory][param.to_sym])
        end
      end
      @device.name = "#{device_params[:subcategory]} ##{Device.where('subcategory Ilike ?', "%#{device_params[:subcategory]}%").count + 1}"
      @device.status = false
      @device.user = current_user
      if @device.save
        redirect_to device_path(@device)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def set_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:category, :subcategory)
  end
end
