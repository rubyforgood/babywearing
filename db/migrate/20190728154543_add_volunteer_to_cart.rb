class AddVolunteerToCart < ActiveRecord::Migration[5.2]
  def change
    change_table :carts do |t|
      t.rename :user_id, :member_id
      t.integer :volunteer_id, nullable: false
    end
  end
end
