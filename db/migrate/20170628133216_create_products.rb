class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, index: true
      t.string :description, index: true
      t.boolean :available, default: true
      t.integer :category_id, index: true

      t.timestamps
    end
  end
end
