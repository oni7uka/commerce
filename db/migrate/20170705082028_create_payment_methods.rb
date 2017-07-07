class CreatePaymentMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_methods do |t|
      t.string :type
      t.string :name
      t.string :description
      t.boolean :active

      t.json :preferences
      
      t.timestamps
    end
    add_index :payment_methods,  [:id, :type]
  end
end
