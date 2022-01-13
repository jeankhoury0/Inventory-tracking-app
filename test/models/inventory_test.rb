require "test_helper"

class InventoryTest < ActiveSupport::TestCase
  def setup
    @inventory = Inventory.create(name: "Montreal Warehouse",
                                  remark: "Montreal location heated has it gets very cold sometime")
    @inventory_item = InventoryItem.create(title: "Mouse", remark: "This is a mouse", price: 20)
  end

  test "should not create inventory without a name" do
    inventory_no_name = Inventory.new(remark: "Montreal location heated has it gets very cold sometime")
    assert_not(inventory_no_name.save, "Saved the Inventory without title")
  end

  test "should not save inventory with a name superior to 50" do
    inventory_sup_to_fifty = Inventory.new(name: "Montreal location heated has it gets very cold sometime")
    assert_not(inventory_sup_to_fifty.save, "Saved the Inventory with a name superior to 50")
  end

  test "should save inventory with no remark" do
    inventory_no_remark = Inventory.new(name: "Montreal Warehouse")
    assert(inventory_no_remark.save, "Did not save Invetory without a remark")
  end

  test "should increment by one if no count param is passed" do
    record = Record.create(quantity: Faker::Number.non_zero_digit, inventory_item_id: @inventory_item.id,
                           inventory_id: @inventory.id)
    expected_quantity = record.quantity + 1

    @inventory.increment(@inventory_item)
    actual_quantity = @inventory.quantity(@inventory_item)

    assert_equal(expected_quantity, actual_quantity, "Inventory count not incremented by one when no param is passed")
  end

  test "should increment by a quantity" do
    record = Record.create(quantity: Faker::Number.non_zero_digit, inventory_item_id: @inventory_item.id,
                           inventory_id: @inventory.id)
    increment = Faker::Number.non_zero_digit.to_i
    expected_quantity = record.quantity + increment

    @inventory.increment(@inventory_item, increment)
    actual_quantity = @inventory.quantity(@inventory_item)

    assert_equal(expected_quantity, actual_quantity)
  end

  test "should be able to find quantity" do
    inventory = Inventory.create(name: "Montreal Warehouse",
                                 remark: "Montreal location heated has it gets very cold sometime")
    record = Record.create(quantity: Faker::Number.non_zero_digit, inventory_item_id: @inventory_item.id,
                           inventory_id: inventory.id)

    expected_quantity = record.quantity
    actual_quantity = inventory.quantity(@inventory_item)

    assert_equal(expected_quantity, actual_quantity)
  end

  test "should be able to extract total quantity" do
    inventory_item_second = InventoryItem.create(title: "Keyboard", remark: "This is a keyboard", price: 30)
    first_record = Record.create(quantity: Faker::Number.non_zero_digit, inventory_item_id: @inventory_item.id,
                                 inventory_id: @inventory.id)
    second_record = Record.create(quantity: Faker::Number.non_zero_digit, inventory_item_id: inventory_item_second.id,
                                  inventory_id: @inventory.id)

    expected_total_quantity = first_record.quantity + second_record.quantity
    actual_total_quantity = @inventory.total_quantity

    assert_equal(expected_total_quantity, actual_total_quantity)
  end
end
