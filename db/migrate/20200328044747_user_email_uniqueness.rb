class UserEmailUniqueness < ActiveRecord::Migration[6.0]
  def up
    remove_index :users, name: :index_users_on_email
    add_index :users, [:organization_id, :email], unique: true
  end
  def down
    remove_index :users, name: :index_users_on_organization_id_and_email
    add_index :users, :email, unique: true
  end
end
