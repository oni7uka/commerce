class CreateVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :variants do |t|
      t.string :name, index: true
      t.decimal :price, precision: 12, scale: 2
      t.references :product, index: true
      t.string :sku ,default: "", null: false, index: true
      t.integer :position
      t.timestamps
    end
  end
end
