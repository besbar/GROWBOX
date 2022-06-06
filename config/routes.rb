Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :plants
  resources :devices do
    resources :alert_settings, only: %i[index new show create]
  end
  resources :alert_settings, only: %i[destroy]
  get "dashboard", to: "pages#dashboard"
  # Defines the root path route ("/")
  # root "articles#index"
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
