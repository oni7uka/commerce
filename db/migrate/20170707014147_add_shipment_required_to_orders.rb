class AddShipmentRequiredToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :shipment_required, :boolean, default: true
  end
end
