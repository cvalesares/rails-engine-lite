Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :update, :destroy]

      get "/api/v1/merchants/:merchant_id/items", to: "merchant_items#index"
    end
  end
end
