class RequireHomeAndCurrentLocationOnCarrier < ActiveRecord::Migration[5.2]
  def change
    change_column_null :carriers, :home_location_id, false
    change_column_null :carriers, :current_location_id, false
  end
end
