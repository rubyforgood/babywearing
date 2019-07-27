class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
     add_column :users, :first_name, :string, null: false
     add_column :users, :last_name, :string, null: false
     add_column :users, :street_address, :string, null: false
     add_column :users, :street_address_second, :string
     add_column :users, :city, :string, null: false
     add_column :users, :state, :string, null: false
     add_column :users, :postal_code, :string, null: false
     add_column :users, :phone_number, :string, null: false
  end
end
