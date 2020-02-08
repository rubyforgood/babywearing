# frozen_string_literal: true

class MembershipType < ApplicationRecord
  validates :name, :fee_cents, :duration_days, :number_of_items, :description, presence: true

  monetize :fee_cents, as: "fee"
end
