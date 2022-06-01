class DevicesController < ApplicationController
  before_action :set_device, only: %i[new]

  def index
    @devices = Device.all
  end

  def show
    @device = Device.find(params[:id])
  end

  def create
  end

  private

  def set_device
    @device = Device.new
  end

  def device_params
    params.require(:devices).permit(:name, :status, :temperature, :air_rh, :ground_rh, :luminosity, :volume, :tank_level)
  end
end
