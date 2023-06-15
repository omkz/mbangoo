Rails.application.routes.draw do
  resources :products
  
  namespace :ngadmin do
      resources :products
      resources :users

      root to: "products#index"
    end
  devise_for :users
  root "home#index"
end
