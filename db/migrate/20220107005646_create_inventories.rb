class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.string :name
      t.string :remark

      t.timestamps
    end

    remove_column :inventory_items, :quantity, :integer
    add_column :inventory_items, :price, :decimal
    add_column :inventory_items, :remark, :string
  end
end
