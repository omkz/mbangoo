Rails.application.routes.draw do
  scope :ngadimin_9877, module: "admin", as: "admin" do
    resources :dashboard, only: [:index]
    resources :products
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
