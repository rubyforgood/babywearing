class DropOrganizations < ActiveRecord::Migration[5.2]
  def change
    drop_table :organizations
  end
end
