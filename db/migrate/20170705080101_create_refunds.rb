class CreateRefunds < ActiveRecord::Migration[5.1]
  def change
    create_table :refunds do |t|
      t.string :number, index: true
      t.integer :payment_id
      t.decimal :amount, precision: 12, scale: 2, default: 0.0, null: false
      t.string :description
      t.integer :operator_id

      t.timestamps
    end
  end
end
