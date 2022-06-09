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
        info_window: render_to_string(partial: "info_window", locals: {site: site}),
        image_url: helpers.asset_url("Shitty_plant.png")
      }
    end

    @search = true if params[:site_name].present? || params[:family].present?

    @plants2 = Plant.all
    if params[:site_name].present?
      @site = @sites.where("sites.name ILIKE ?", params[:site_name])[0].id
      @plants_location = @plants2.where("cast(plants.site_id as text) ILIKE ?", "%#{@site}%")
    else
      @plants_location = @plants2
    end

    if params[:family].present?
      @plants3 = @plants_location.where("plants.family ILIKE ?", params[:family])
    else
      @plants3 = @plants_location
    end
  end
end
