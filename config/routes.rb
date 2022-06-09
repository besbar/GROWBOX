Rails.application.routes.draw do
  root to: "pages#home"

  resources :devices do
    resources :alert_settings, only: %i[index new show create]
  end

  resources :alert_settings, only: %i[destroy]

  get "dashboard", to: "pages#dashboard"

  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users

  resources :sites, only: %i[index show new create]

  resources :plants do
    member do
      get :for_temperature_air_rh
      get :for_ground_rh
      get :metrics
      get :watering
    end
  end
end
