class Carrier < ApplicationRecord
  belongs_to :location

  validates_presence_of [
    :name,
    :item_id,
    :manufacturer,
    :model,
    :color,
    :location_id,
    :default_loan_length_days
  ]
end
