class InventoryItemController < ApplicationController
  before_action :set_inventory

  def index
    @inventory_items = InventoryItem.all
    # render json: @InventoryItems if request.content_type == "application/json"
  end

  def show
    @inventory_item = InventoryItem.find(params[:id])
  end

  def new
    @inventory_item = InventoryItem.new
    @inventories = Inventory.all
  end

  def create
    @inventory_item = InventoryItem.new(inventory_item_params)
    if @inventory_item.save
      flash[:success] = "Inventory Item successfully created"
      redirect_to @inventory_item
    else
      respond_to do |format|
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def increment
    # MOUSE
    # ...
    # Add to inventory
    # count: ---, inventory: ---
    @inventory_item = InventoryItem.find(params[:id])
    @inventory_item.increment(@inventory, params[:count] || 1)
  end

  private

  def inventory_item_params
    params.permit(:title, :price, :remark)
  end

  def set_inventory
    @inventory = Inventory.find(params[:inventory_id]) if params[:inventory_id]
  end
end
