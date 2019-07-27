class Carrier < ApplicationRecord
  belongs_to :location
  belongs_to :category

  validates :item_id, uniqueness: { message: 'Item ID has already been taken' }
  validates_presence_of [
    :name,
    :item_id,
    :location_id,
    :default_loan_length_days,
    :category_id
  ]
end
