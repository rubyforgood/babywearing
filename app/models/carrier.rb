class Carrier < ApplicationRecord
  validates_presence_of [
    :name,
    :item_id,
    :manufacturer,
    :model,
    :color,
    :location_id
  ]
end
