class CreateCarriers < ActiveRecord::Migration[5.2]
  def change
    create_table :carriers do |t|
      t.string :item_id
      t.string :name
      t.string :manufacturer
      t.string :model
      t.string :color
      t.integer :size
      t.integer :location_id
      t.integer :default_loan_length_days, :default => 30
      t.timestamps
    end
  end
end
