class AddMobileValidToAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :mobile_valid, :boolean, default: false
  end
end
