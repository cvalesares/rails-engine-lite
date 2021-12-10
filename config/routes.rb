Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "/merchants/find", to: "merchants_search#find"

      resources :merchants, only: [:index, :show] do
        resources :items, action: :index, controller: 'merchant_items'
      end

      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, action: :show, controller: 'item_merchants'
      end

    end
  end
end
