Rails.application.routes.draw do
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users

  root to: "pages#home"

  get "dashboard", to: "pages#dashboard"

  resources :plants do
    member do
      get :for_temperature_air_rh
      get :for_ground_rh
      get :metrics
    end
  end

  resources :devices do
    resources :alert_settings, only: %i[index new show create]
  end

  resources :alert_settings, only: %i[destroy]
end
