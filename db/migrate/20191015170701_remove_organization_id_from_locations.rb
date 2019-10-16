class RemoveOrganizationIdFromLocations < ActiveRecord::Migration[5.2]
  def change
    remove_column :locations, :organization_id, :integer
  end
end
