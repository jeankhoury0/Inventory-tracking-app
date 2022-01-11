Rails.application.routes.draw do
  root "main#index"
  
  resources :inventory_item do
    get "inventory_items", to: "inventory_item#index" 
    get "/new-inventory-item", to: "inventory_item#create"
  end
 
  resources :inventories do
    resources :inventory_item do
      post :increment, on: :member
    end

    get :report, on: :collection
    post :increment, on: :member
  end
end
