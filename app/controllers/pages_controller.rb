class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @user = current_user
    @plants = Plant.all.where(user: @user)
    @devices = Device.all.where(user: @user)
  end
end
