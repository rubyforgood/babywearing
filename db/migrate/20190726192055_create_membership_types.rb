class CreateMembershipTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :membership_types do |t|
      t.string :name
      t.integer :fee_cents
      t.integer :duration_days
      t.integer :number_of_items
      t.text :description

      t.timestamps
    end
  end
end
