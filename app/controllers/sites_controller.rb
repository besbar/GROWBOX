class SitesController < ApplicationController
  def index
    @sites = Site.all
  end

  def show
    @site = Site.find(params[:id])
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    @site.user = current_user
    if @site.save
      redirect_to site_path(@site)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def site_params
    params.require(:site).permit(:name, :address, :id)
  end
end
