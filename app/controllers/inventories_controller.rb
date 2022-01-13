# frozen_string_literal: true

require "csv"

# Controller for inventory controller
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

  # GET /inventories/new
  def new
    @inventory = Inventory.new
  end

  # GET /inventories/1/edit
  def edit; end

  # POST /inventories
  def create
    @inventory = Inventory.new(inventory_params)
    if @inventory.save
      respond_to do |format|
        format.json { render json: @inventory, status: :created, location: @inventory }
        format.html { redirect_to inventory_url(@inventory), notice: "Inventory was successfully created."}
      end
    else
      respond_to do |format|
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventories/1 or /inventories/1.json
  def update
    respond_to do |format|
      if @inventory.update(inventory_params)
        format.html do
          redirect_to inventory_url(@inventory), notice: "Inventory was successfully updated."
        end
        format.json { render :show, status: :ok, location: @inventory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1 or /inventories/1.json
  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url, notice: "Inventory was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /inventories/1/increment
  # needs inventory_item_id and count
  def increment
    @inventory = Inventory.find(params[:id])
    @inventory_item = InventoryItem.find(params[:inventory_item_id])
    @inventory.increment(@inventory_item, params[:count].to_i || 1)
    redirect_to @inventory
  end

  def report
    @inventories = Inventory.all
    @records = Record.all
    respond_to do |format|
      format.xlsx { render xlsx: "report" }
      format.csv { send_data @inventories.to_csv, filename: "Inventory-Report-#{Date.today}.csv" }
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
