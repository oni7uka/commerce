class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :number, index: true
      t.decimal :amount, precision: 12, scale: 2, default: 0.0, null: false

      t.integer :order_id, index: true
      t.integer :payment_method_id, index: true

      t.string :state
      t.timestamps
    end
  end
end
