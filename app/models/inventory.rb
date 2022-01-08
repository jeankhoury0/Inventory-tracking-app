class Inventory < ApplicationRecord
    has_many :inventory_items
    
    validates :name, presence: true, length: { maximum: 50 }
end
