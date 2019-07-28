class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.integer :cart_id, nullable: false
      t.integer :carrier_id, nullable: false
      t.date :due_date, nullable: false

      t.timestamps
    end
  end
end
