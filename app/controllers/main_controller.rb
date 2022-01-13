class MainController < ApplicationController
  def index
    @inventory_items = InventoryItem.all
    @inventories = Inventory.all
  end
end
