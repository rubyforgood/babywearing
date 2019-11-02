class MergeCartAndLoan < ActiveRecord::Migration[5.2]
  def change
    add_reference :loans, :checkin_volunteer, foreign_key: { to_table: :users }
    add_reference :loans, :checkout_volunteer, foreign_key: { to_table: :users }
    add_reference :loans, :member, foreign_key: { to_table: :users }, null: false

    add_column :loans, :returned_at, :datetime

    remove_column :loans, :cart_id, :integer

    drop_table :carts
  end
end
