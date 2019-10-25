class AddSafetyLinkToCarriers < ActiveRecord::Migration[5.2]
  def change
    add_column :carriers, :safety_link, :string
  end
end
