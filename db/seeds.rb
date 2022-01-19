def seed
  8.times do |_i|
    generate_inventories
    generate_inventory_items
  end
  associate
end

def generate_inventories
  Inventory.create(
    name: FFaker::AddressCA.city,
    remark: FFaker::Lorem.paragraph
  )
end

def generate_inventory_items
  InventoryItem.create(
      [
        { title: FFaker::Product.product.split.last,
          remark: FFaker::Product.model,
          price: FFaker::Number.number }
      ]
    )
end

def associate
  random_number_inventory = rand(1...Inventory.count).to_i

  InventoryItem.last(8).each do |item|
    Inventory.last(random_number_inventory).each do |inventory|
      Record.create(
        {
          quantity: FFaker::Number.number,
          inventory_item_id: item.id,
          inventory_id: inventory.id
        }
      )
    end
  end
end

ActiveRecord::Base.transaction do
  seed
end
