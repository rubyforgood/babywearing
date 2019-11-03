class AddFirstNameandLastNameToUsersTable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    remove_column :users, :full_name, :string

    User.update_all first_name: "First"
    User.update_all last_name: "Last"
  end
end
