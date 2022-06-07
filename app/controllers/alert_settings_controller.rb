class AlertSettingsController < ApplicationController
  before_action :set_device, only: %i[index new create show]

  def index
    @alert_settings = AlertSetting.all
  end

  def show
    @alert_setting = AlertSetting.find(params[:id])
  end

  def new
    @alert_setting = AlertSetting.new
  end

  def create
    @alert_setting = AlertSetting.new(alert_setting_params)
    @alert_setting.sensor = @device
    if @alert_setting.save
      redirect_to device_path(@alert_setting.sensor_id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @alert_setting = AlertSetting.find(params[:id])
    @alert_setting.destroy
    redirect_to device_alert_settings_path(@alert_setting.sensor_id)
  end

  private

  def alert_setting_params
    params.require(:alert_setting).permit(:description, :temperature_min, :temperature_max, :air_rh_min, :air_rh_max, :tank_level_min, :ground_rh_min, :ground_rh_max, :luminosity_min, :luminosity_max)
  end

  def set_device
    @device = Device.find(params[:device_id])
  end
end
