class Carrier < ApplicationRecord
  belongs_to :location
  has_many :loans

  validates_presence_of [
    :name,
    :item_id,
    :manufacturer,
    :model,
    :color,
    :location_id,
    :default_loan_length_days
  ]

  def build_loan(attributes = {})
    loans.create({
      due_date: Date.today + default_loan_length_days.days,
    }.merge(attributes))
  end
end
