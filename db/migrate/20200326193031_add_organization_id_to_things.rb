class AddOrganizationIdToThings < ActiveRecord::Migration[6.0]
  def change
    add_column :agreements, :organization_id, :integer
    add_column :carriers, :organization_id, :integer
    add_column :fee_types, :organization_id, :integer
    add_column :locations, :organization_id, :integer
    add_column :membership_types, :organization_id, :integer
    add_column :users, :organization_id, :integer
  end
end
