class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :subdomain, null: false, index: true
      t.string :email
      t.string :phone
      t.text :notes
      t.string :address
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
