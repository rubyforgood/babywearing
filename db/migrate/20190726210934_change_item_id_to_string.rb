class ChangeItemIdToString < ActiveRecord::Migration[5.2]
  def change
    change_column :carriers, :item_id, :string
  end
end
