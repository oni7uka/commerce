class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :number, index: true
      t.decimal :item_total, precision: 12, scale: 2, default: 0.0,     null: false
      t.decimal :total, precision: 12, scale: 2, default: 0.0,     null: false
      t.integer :item_count, default: 0, null: false

      t.string :state, index: true

      t.integer :user_id, null: false
      t.integer :canceled_by
      t.integer :ship_address_id

      t.datetime :completed_at
      t.datetime :canceled_at

      t.timestamps
    end
  end
end
