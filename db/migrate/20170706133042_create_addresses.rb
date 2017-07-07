class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :mobile
      t.string :receiver
      t.string :zip_code

      t.timestamps
    end
  end
end
