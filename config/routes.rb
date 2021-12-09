Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, action: :show, controller: 'item_merchants'
      end

      # get "/api/v1/items/:item_id/merchant", to: "item_merchants#show"
      # get "/api/v1/merchants/:merchant_id/items", to: "merchant_items#index"
    end
  end
end
