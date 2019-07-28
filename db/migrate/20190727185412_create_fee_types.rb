class CreateFeeTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :fee_types do |t|
      t.string :name, null: false
      t.integer :amount
      t.timestamps
    end
  end
end
