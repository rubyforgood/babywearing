# frozen_string_literal: true

class Carrier < ApplicationRecord
  include Carrier::FilterImpl

  belongs_to :home_location, class_name: 'Location'
  belongs_to :current_location, class_name: 'Location'
  has_many :loans
  belongs_to :category

  validates :item_id, uniqueness: { message: 'Item ID has already been taken' }
  validates_presence_of [
    :name,
    :item_id,
    :home_location_id,
    :current_location_id,
    :default_loan_length_days,
    :category_id
  ]

  has_many_attached :photos

  enum status: %i[available unavailable disabled sold]

  alias available_for_checkout? available?

  def build_loan(attributes = {})
    loans.create({
      due_date: Date.today + default_loan_length_days.days
    }.merge(attributes))
  end
end
