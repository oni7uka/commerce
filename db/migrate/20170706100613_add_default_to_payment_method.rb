class AddDefaultToPaymentMethod < ActiveRecord::Migration[5.1]
  def up
    add_column :payment_methods, :default, :boolean, default: false
    change_column :payment_methods, :active, :boolean, default: true
  end

  def down
    remove_column :payment_methods, :default, :boolean
    change_column :payment_methods, :active, :boolean
  end
end
