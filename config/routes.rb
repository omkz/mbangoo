Rails.application.routes.draw do
  namespace :admin do
    resources :categories
    resources :dashboard, only: [:index]
    resources :products do
      resources :variants
      resources :images
    end
    resources :option_types
    resources :option_values
  end

  resources :products
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  resources :payments, only: [:index] do
    get 'charges', on: :collection
    post 'webhook', on: :collection
  end

  devise_for :users

  root "home#index"

end
