# frozen_string_literal: true

class MembershipType < ApplicationRecord
  acts_as_tenant(:organization)

  monetize :fee_cents, as: 'fee'

  validates :name, :short_name, :fee_cents, :duration_days, :number_of_items, presence: true
end
