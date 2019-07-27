class ChangeSizeToStringForCarriers < ActiveRecord::Migration[5.2]
  def change
    change_column :carriers, :size, :string
  end
end
