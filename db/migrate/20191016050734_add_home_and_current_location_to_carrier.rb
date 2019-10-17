class AddHomeAndCurrentLocationToCarrier < ActiveRecord::Migration[5.2]
  def change
    add_reference :carriers, :home_location, foreign_key: { to_table: :locations }
    add_reference :carriers, :current_location, foreign_key: { to_table: :locations }

    Carrier.all.each do |carrier|
      carrier.update(home_location_id: carrier.location_id, current_location_id: carrier.location_id)
    end

    remove_column :carriers, :location_id, :integer
  end
end
