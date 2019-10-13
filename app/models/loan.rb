# frozen_string_literal: true

class Loan < ApplicationRecord
  belongs_to :cart
  belongs_to :carrier

  validates :cart, :carrier, :due_date, presence: true
end
