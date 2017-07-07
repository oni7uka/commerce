class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.integer :variant_id, index: true
      t.integer :order_id, index: true
      t.integer :quantity, default: 0
      t.decimal :price, precision: 12, scale: 2, default: 0.0,     null: false

      t.timestamps
    end
  end
end
