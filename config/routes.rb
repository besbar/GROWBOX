Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :plants
  resources :devices do
    resources :alert_settings, only: %i[index new show create]
  end
  resources :alert_settings, only: %i[destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
