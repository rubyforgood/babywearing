class AddWeightLimitToCarrier < ActiveRecord::Migration[5.2]
  def change
    add_column :carriers, :weight_limit, :integer
  end
end
