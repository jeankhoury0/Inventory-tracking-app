require "test_helper"

class InventoryItemTest < ActiveSupport::TestCase
  def setup
    @inventory = Inventory.create(name: "Montreal Warehouse",
                                  remark: "Montreal location heated has it gets very cold sometime")
    @inventory_item = InventoryItem.create(title: "Mouse", remark: "This is a mouse", price: 20)
  end

  test "should not create inventory without a title" do
    inventory_item_no_name = InventoryItem.new(remark: "This is a mouse", price: 20)
    assert_not(inventory_item_no_name.save, "Saved the Inventory Item without name")
  end

  test "should save inventory with no remark and / or price" do
    inventory_item_no_remark = InventoryItem.new(title: "Montreal Warehouse", price: 20)
    assert(inventory_item_no_remark.save, "Did not save Invetory without a remark")

    inventory_item_no_price = InventoryItem.new(title: "Montreal Warehouse", remark: "This is a remark")
    assert(inventory_item_no_price.save, "Did not save Invetory without a price")

    inventory_item_no_remark_price = InventoryItem.new(title: "Montreal Warehouse")
    assert(inventory_item_no_remark_price.save, "Did not save Invetory without a price and a price")
  end

  test "should not save inventory with a name superior to 50" do
    inventory_item_fifty = InventoryItem.new(title: "Montreal location heated has it gets very cold sometime")
    assert_not(inventory_item_fifty.save, "Saved the Inventory with a name superior to 50")
  end

  # TODO: add tests to mirror
end
