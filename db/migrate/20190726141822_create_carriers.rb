class CreateCarriers < ActiveRecord::Migration[5.2]
  def change
    create_table :carriers do |t|
      t.integer :item_id
      t.string :name
      t.string :manufacturer
      t.string :model
      t.string :color
      t.string :size
      t.integer :location_id
      t.integer :default_loan_length, :default => 30
      t.timestamps
    end
  end
end
