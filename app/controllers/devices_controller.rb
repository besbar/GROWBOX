class DevicesController < ApplicationController
  before_action :set_device, only: %i[new]

  def index
    @devices = Device.all
  end

  def show
    @device = Device.find(params[:id])
  end

  private

  def set_device
    @device = Device.new
  end
end
