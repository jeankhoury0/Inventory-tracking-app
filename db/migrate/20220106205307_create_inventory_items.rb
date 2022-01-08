class CreateInventoryItems < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_items do |t|
      t.string :title
      t.integer :quantity

      t.timestamps
    end
  end
end
