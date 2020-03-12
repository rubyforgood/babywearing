class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.references :user, foreign_key: true
      t.references :membership_type, foreign_key: true
      t.date :effective, null: false, index: true
      t.date :expiration, null: false, index: true
      t.timestamps
    end
  end
end
