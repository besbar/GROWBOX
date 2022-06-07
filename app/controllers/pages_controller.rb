class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @user = current_user
    @sites = Site.all.where(user: @user)
    @plants = Plant.all.where(site_id: @sites)
    @devices = Device.all.where(user: @user)
    @alert_settings = @devices.map { |device| device.alert_settings }.flatten
    @markers = @sites.geocoded.map do |site|
      {
        lat: site.latitude,
        lng: site.longitude,
        info_window: render_to_string(partial: "info_window", locals: {site: site})
      }
    end
  end
end
