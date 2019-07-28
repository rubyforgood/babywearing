class AddCategoryIdToCarriers < ActiveRecord::Migration[5.2]
  def change
    add_column :carriers, :category_id, :integer
  end
end
