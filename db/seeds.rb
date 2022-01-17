# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def seed
  10.times do |i|
    
    Inventory.create(
      name: FFaker::AddressCA.city,
      remark: FFaker::Lorem.paragraph
    )


    InventoryItem.create(
      [
        { title: FFaker::Product.product.split.last, 
          remark: FFaker::Product.model, 
          price: FFaker::Number.number },
      ]
    )
  end

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
