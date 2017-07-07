class CreateStockChanges < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_changes do |t|
      t.integer :variant_id, index: true
      t.integer :quantity,  default: 0, null: false
      t.integer :source_id
      t.string :source_type
      t.timestamps
    end

    add_index :stock_changes,  [:source_id, :source_type]
  end
end
