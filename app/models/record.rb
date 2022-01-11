class Record < ApplicationRecord
  belongs_to :inventory
  belongs_to :inventory_item

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :inventory_id, uniqueness: { scope: :inventory_item_id }
end
