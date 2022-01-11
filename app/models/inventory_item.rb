class InventoryItem < ApplicationRecord
  has_many :records, dependent: :delete_all
  has_many :inventories, through: :records

  def increment(inventory, count = 1)
    record = Record.find_or_create_by(inventory_item_id: id, inventory_id: inventory.id)
    record.quantity += count
    record.save
  end

  def quantity(inventory)
    record = Record.find_by(inventory_item_id: id, inventory_id: inventory.id)
    record.quantity
  end
end
