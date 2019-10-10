# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :member, class_name: "User"
  validates :member, presence: true

  belongs_to :volunteer, class_name: "User"
  validates :volunteer, presence: true

  has_many :loans

  def line_items
    loans
  end
end
