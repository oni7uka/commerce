class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :assets do |t|
      t.integer :viewable_id, index: true
      t.string :viewable_type, index: true
      t.string :attachment
      t.integer :position
      t.string :alt

      t.timestamps
    end
  end
end
