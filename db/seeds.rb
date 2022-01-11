# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def seed
  InventoryItem.create(
    [
      { title: "Mouse", remark: "This is a mouse", price: 20 },
      { title: "Keyboard", remark: "This is a keyboard", price: 25 },
      { title: "Monitor", remark: "This is a Monitor", price: 299 },
      { title: "Webcam", remark: "This is a Webcam", price: 300 }
    ]
  )

  Inventory.create(
    [
      { name: "Montreal Warehouse", remark: "Montreal location heated has it gets very cold sometime"},
      { name: "Miami Warehouse" },
      { name: "West Tokyo Warehouse" },
      { name: "Space Warehouse" }
    ]
  )

  InventoryItem.all.each do |item|
    Inventory.all.each do |inventory|
      item_quantity = Faker::Number.non_zero_digit
      Record.create(
        {
          quantity:          item_quantity,
          inventory_item_id: item.id,
          inventory_id:      inventory.id
        }
      )
    end
  end
end

ActiveRecord::Base.transaction do
  seed
end
