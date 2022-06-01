class AlertSettingsController < ApplicationController
  before_action :set_alert_setting, only: %i[new]

  def index
    @alert_settings = Alert_setting.all
  end

  def show
    @alert_setting = Alert_setting.find(params[:id])
  end

  def new
  end

  private

  def set_alert_setting
    @alert_setting = Alert_setting.new
  end

  # def alert_setting_params
  #   params.require(:alert_settings).permit(:)
  # end
end
