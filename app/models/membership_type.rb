class MembershipType < ApplicationRecord
  validates :name, :fee, :duration, :number_of_items, :description, presence: true
end
