Rails.application.routes.draw do
  root "inventory_item#index"
  
  get "/new-inventory-item", to: "inventory_item#create"
  resources :inventory_item

  resources :inventories do 
    resources :inventory_item
  end


end
