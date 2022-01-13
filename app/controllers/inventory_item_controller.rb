class InventoryItemController < ApplicationController
  before_action :set_inventory

  # GET /inventory_item
  def index
    @inventory_items = InventoryItem.all
    respond_to do |format|
      format.json { render json: @inventory_items }
      format.html { render :index }
    end
  end

  def show
    # TODO remove @inventory_item
    @inventory_item = InventoryItem.find(params[:id])
    respond_to do |format|
      format.json { render json: @inventory }
      format.html { render :show }
    end
  end

  def new
    @inventory_item = InventoryItem.new
  end

  def edit; end

  def create
    @inventory_item = InventoryItem.new(inventory_item_params)
    if @inventory_item.save
      respond_to do |format|
        format.json { render json: @inventory_item, status: :created, location: @inventory }
        format.html { redirect_to inventory_item_url(@inventory_item_params), notice: "Inventory Item successfully created."}
      end
    else
      respond_to do |format|
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @inventory_item.update(inventory_item_params)
        respond_to do |format|
          format.json { render :show, status: :ok, location: @inventory_item }
          format.html{ redirect_to inventory_item_url(@inventory_item), notice: "Inventory Item was successfully updated." }
        end
      else
        respond_to do |format|
          format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @inventory_item = InventoryItem.find(params[:id])
    @inventory_item.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.html { redirect_to inventory_item_url, notice: "Inventory item was successfully destroyed." }
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

  # POST /inventories/1/increment
  # needs inventory_item_id and count
  def increment
    @inventory_item = InventoryItem.find(params[:id])
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_item.increment(@inventory, params[:count].to_i || 1)
    redirect_to @inventory_item
  end

  private

  def inventory_item_params
    params.permit(:title, :price, :remark)
  end

  def set_inventory
    @inventory = Inventory.find(params[:inventory_id]) if params[:inventory_id]
  end
end
