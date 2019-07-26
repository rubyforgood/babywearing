class Carrier < ApplicationRecord
  validates_presence_of [
    :name,
    :item_id,
    :manufacturer,
    :model,
    :color,
    :size,
    :location_id
  ]
end
