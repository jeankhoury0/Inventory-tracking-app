class Inventory < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }

  has_many :records, dependent: :delete_all
  has_many :inventory_items, through: :records

  def increment(inventory_item, count = 1)
    record = Record.find_or_create_by(inventory_item_id: inventory_item.id, inventory_id: id)
    record.quantity += count
    record.save
  end

  def quantity(inventory_item)
    record = Record.find_by(inventory_item_id: inventory_item.id, inventory_id: id)
    record.quantity
  end

  def total_quantity
    total = 0
    records.each do |inventory_record|
      total += inventory_record.quantity
    end
    total
  end

  def proportions
    total = total_quantity

    calculated_proportions = {}
    records.each do |record|
      calculated_proportions[record.inventory_item] = record.quantity / total
    end
    calculated_proportions
  end
end
