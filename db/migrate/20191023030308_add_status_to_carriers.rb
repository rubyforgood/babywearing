class AddStatusToCarriers < ActiveRecord::Migration[5.2]
  def change
    change_table :carriers do |t|
      t.column :status, :integer, default: 0, null: false
    end
  end
end
