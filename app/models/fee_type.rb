# frozen_string_literal: true

class FeeType < ApplicationRecord
  validates_presence_of :name, :fee_cents

  monetize :fee_cents, as: "fee"
end
