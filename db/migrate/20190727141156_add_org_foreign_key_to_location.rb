class AddOrgForeignKeyToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :organization_id, :integer
  end
end
