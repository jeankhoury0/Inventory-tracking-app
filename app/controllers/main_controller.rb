class MainController < ApplicationController
  def index
    @inventory_items = InventoryItem.all
    @inventories = Inventory.all
  end

  def seed
    Rails.application.load_seed
    redirect_to root_path
  end
end
