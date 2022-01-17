# Controller for inventory items
class InventoryItemsController < ApplicationController
  before_action :set_inventory_item, only: %i[show edit update destroy]

  # GET /inventory_items
  def index
    @inventory_items = InventoryItem.all
    respond_to do |format|
      format.json { render json: @inventory_items }
      format.html { render :index }
    end
  end

  # GET inventory_items/1
  def show
    @inventories = Inventory.all
    respond_to do |format|
      format.json { render json: @inventory }
      format.html { render :show }
    end
  end

  def new
    @inventory_item = InventoryItem.new
  end

  def edit; end

  # POST /inventory_items
  def create
    @inventory_item = InventoryItem.new(inventory_item_params)
    if @inventory_item.save
      respond_to do |format|
        format.json { render json: @inventory_item, status: :created, location: @inventory_item }
        format.html { redirect_to inventory_item_url(@inventory_item), notice: "Inventory Item successfully created." }
      end
    else
      respond_to do |format|
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_items/1
  def update
    respond_to do |_format|
      if @inventory_item.update(inventory_item_params)
        respond_to do |format|
          format.json { render :show, status: :ok, location: @inventory_item }
          format.html do
            redirect_to inventory_item_url(@inventory_item), notice: "Inventory Item was successfully updated."
          end
        end
      else
        respond_to do |format|
          format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /inventory_items/1
  def destroy
    @inventory_item = InventoryItem.find(params[:id])
    @inventory_item.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.html { redirect_to inventory_item_url, notice: "Inventory item was successfully destroyed." }
    end
  end

  # POST /inventories/1/increment
  def increment
    @inventory_item = InventoryItem.find(params[:id])
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_item.increment(@inventory, params[:count] || 1)
    redirect_to @inventory_item
  end

  def assign
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_item = InventoryItem.find(params[:id])
    begin
      @inventory.assign(@inventory_item)
      respond_to do |format|
        format.json { render json: "OK", status: :ok }
        format.html { redirect_to @inventory_item }
      end
    rescue StandardError => e
      respond_to do |format|
        format.json { render json: e, status: :unprocessable_entity }
        format.html { redirect_to @inventory_item, notice: e }
      end
    end
  end

  private

  def inventory_item_params
    params.fetch(:inventory_item, {}).permit(:title, :price, :remark)
  end

  def set_inventory_item
    @inventory_item = InventoryItem.find(params[:id])
  end
end
