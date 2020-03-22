class ActivationRefactor < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :deactivated_at
    add_column :memberships, :blocked, :boolean, default: false
    add_column :memberships, :notes, :text
  end

  def down
    add_column :users, :deactivated_at, :datetime
    remove_column :memberships, :blocked
    remove_column :memberships, :notes
  end
end
