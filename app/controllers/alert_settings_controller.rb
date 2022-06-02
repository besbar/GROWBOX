class AlertSettingsController < ApplicationController
  before_action :set_alert_setting, only: %i[new]
  before_action :set_device, only: %i[new create]

  def index
    @alert_settings = Alert_setting.all
  end

  def show
    @alert_setting = Alert_setting.find(params[:id])
  end

  def new
  end

  def create
  end

  private

  def set_alert_setting
    @alert_setting = Alert_setting.new
  end

  def alert_setting_params
    params.require(:devices).permit(:description, :temperature_min, :temperature_max, :air_rh_min, :air_rh_max, :tank_level_min, :ground_rh_min, :ground_rh_min, :luminosity_min, :luminosity_max)
  end

  def set_device
    @device = Device.new
  end
end
