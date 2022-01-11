require "test_helper"

class RecordTest < ActiveSupport::TestCase

  def setup 
    @inventory_item = InventoryItem.new(title: "Mouse", remark: "This is a mouse", price: 20 ) 
    @invetory =  InventoryItem.new(name: "Montreal Warehouse", remark: "Montreal location heated has it gets very cold sometime")
    @record = Record.new(quantity: 20, inventory_item_id: inventory_item, inventory_id: inventory.id )
  end

  test "record should be valid" do
    assert @record.valid?
  end
  # test "the truth" do
  #   assert true
  # end
end
