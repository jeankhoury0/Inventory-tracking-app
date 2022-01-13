Rails.application.routes.draw do
  root "inventories#index"

  resources :inventory_item do
    get "/inventory_items", to: "inventory_item#index"
    post "/new-inventory-item", to: "inventory_item#create"
    post :increment, on: :member
  end

  resources :inventories do
    resources :inventory_item do
      post :increment, on: :member
    end

    get :report, on: :collection
    post :increment, on: :member
  end
end
