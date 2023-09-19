Rails.application.routes.draw do
  resources :products
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  resources :payments, only: [:index] do
    get 'charges', on: :collection
    post 'webhook', on: :collection
  end

  namespace :ngadmin do
      resources :products
      resources :users

      root to: "products#index"
    end
  devise_for :users

  root "home#index"

end
