class InventoryItemController < ApplicationController
  before_action :set_inventories

  def index
    render json: @InventoryItems if request.content_type == "application/json"
  end

  def show
    @inventory_item = InventoryItem.find(params[:id])
  end

  def new
    @inventory_item = InventoryItem.new
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

  private

  def inventory_item_params
    params.permit(:title, :quantity, :inventory_id)
  end

  def set_inventories
    @inventory_items =
      if params[:inventory_id]
        Inventory.find(params[:inventory_id]).inventory_items
      else
        InventoryItem.all
      end
  end
end
