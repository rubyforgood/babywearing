class AddShortNameToMembershipTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :membership_types, :short_name, :string, null: false
  end
end
