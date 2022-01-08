class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.string :name

      t.timestamps
    end
    add_reference :inventory_items, :inventory, foreign_key: true

  end
end
