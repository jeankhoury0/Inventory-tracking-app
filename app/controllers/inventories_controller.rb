require "csv"

# Controller for inventory
class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[show edit update destroy]

  # GET /inventories
  def index
    @inventories = Inventory.all
    respond_to do |format|
      format.json { render json: @inventories }
      format.html { render :index }
    end
  end

  # GET /inventories/1
  def show
    @inventory_items = InventoryItem.all
    respond_to do |format|
      format.json { render json: @inventory }
      format.html { render :show }
    end
  end

  def new
    @inventory = Inventory.new
  end

  # PUT/PATCH /inventories/1/edit
  def edit; end

  # POST /inventories
  def create
    @inventory = Inventory.new(inventory_params)
    if @inventory.save
      respond_to do |format|
        format.json { render json: @inventory, status: :created, location: @inventory }
        format.html { redirect_to root_path, notice: "Inventory was successfully created." }
      end
    else
      respond_to do |format|
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventories/1
  def update
    if @inventory.update(inventory_params)
      respond_to do |format|
        format.json { render :show, status: :ok, location: @inventory }
        format.html { redirect_to root_path, notice: "Inventory was successfully updated." }
      end
    else
      respond_to do |format|
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1 or /inventories/1.json
  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.html { redirect_to inventories_url, notice: "Inventory was successfully destroyed." }
    end
  end

  # POST /inventories/1/increment
  def increment
    @inventory = Inventory.find(params[:id])
    @inventory_item = InventoryItem.find(params[:inventory_item_id])

    @inventory.increment(@inventory_item, params[:count] || 1)
    redirect_to @inventory
  end

  def assign
    @inventory = Inventory.find(params[:id])
    @inventory_item = InventoryItem.find(params[:inventory_item_id])
    begin
      @inventory.assign(@inventory_item)
      respond_to do |format|
        format.json { render json: "OK", status: :ok }
        format.html { redirect_to @inventory }
      end
    rescue StandardError => e
      respond_to do |format|
        format.json { render json: e, status: :unprocessable_entity }
        format.html { redirect_to @inventory, notice: e }
      end
    end
  end

  def report
    @inventories = Inventory.all
    @records = Record.all
    respond_to do |format|
      inventory_report_name = "Inventory-Report-#{Date.today}"
      format.xlsx { render xlsx: "report", filename: inventory_report_name }
      format.csv { send_data @inventories.to_csv, filename: "#{inventory_report_name}.csv" }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def inventory_params
    params.fetch(:inventory, {}).permit(:name, :remark)
  end
end
