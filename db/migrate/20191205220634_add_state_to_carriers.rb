class AddStateToCarriers < ActiveRecord::Migration[5.2]
  def up
    remove_column :carriers, :status
    add_column :carriers, :state, :string, default: 'available', null: false
    add_index :carriers, :state
  end

  def down
    remove_column :carriers, :state
    add_column :carriers, :status, :integer, default: 0, null: false
  end
end
