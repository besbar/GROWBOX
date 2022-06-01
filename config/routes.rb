Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :plants
  resources :devices
  resources :alert_settings
  # Defines the root path route ("/")
  # root "articles#index"
end
