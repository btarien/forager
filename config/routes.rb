Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :products, only: [:index, :show]
  resources :groceries, only: [:index, :create, :update, :destroy]
  resources :favorites, only: [:index, :create, :destroy]
  # get 'products/:address', to: 'products#hash_of_store_products', as: 'filter'

end
