class MembershipType < ApplicationRecord
  validates :name, :fee_cents, :duration_days, :number_of_items, :description, presence: true
end
