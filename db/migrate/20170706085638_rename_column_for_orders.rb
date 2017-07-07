class RenameColumnForOrders < ActiveRecord::Migration[5.1]
  def change
    rename_column(:orders, :canceled_by, :refunded_by)
  end
end
