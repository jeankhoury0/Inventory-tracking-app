class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.integer :quantity, default: 0
      t.references :inventory, null: false, foreign_key: true
      t.references :inventory_item, null: false, foreign_key: true

      t.timestamps
    end

    add_index :records, %i[inventory_id inventory_item_id], unique: true
  end
end
