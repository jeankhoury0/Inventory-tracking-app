Rails.application.routes.draw do
  root "main#index" 
  get "/seed", to: "main#seed"

  # resources :inventory_item do
  #   get "/inventory_items", to: "inventory_item#index"
  #   get "/new-inventory-item", to: "inventory_item#create"
  #   post :increment, on: :member
  # end

  resources :inventory_items do
    post :increment, on: :member
    post :assign, on: :member
    resources :inventory do
      post :increment, on: :member
    end
    
  end

  resources :inventories do
    get :report, on: :collection
    post :increment, on: :member
    post :assign, on: :member
    resources :inventory_item do
      post :increment, on: :member
    end

    
  end
end
