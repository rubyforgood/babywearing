# frozen_string_literal: true

class Carrier < ApplicationRecord
  acts_as_tenant(:organization)

  include AASM
  include Carrier::FilterImpl

  belongs_to :category
  belongs_to :current_location, class_name: 'Location'
  belongs_to :home_location, class_name: 'Location'
  belongs_to :organization

  has_many :loans, dependent: :destroy

  validates :item_id, uniqueness: { message: 'Item ID has already been taken' }
  validates_presence_of %i[
    name
    item_id
    home_location_id
    current_location_id
    default_loan_length_days
    category_id
  ]

  has_many_attached :photos

  aasm column: 'state' do
    state :available, initial: true
    state :out_of_service
    state :sold
    state :checked_out

    event :take_out_of_service do
      transitions from: [:available], to: :out_of_service
    end

    event :make_available do
      transitions from: [:out_of_service], to: :available
    end

    event :sell do
      transitions from: %i[available out_of_service], to: :sold
    end

    event :checkout do
      transitions from: [:available], to: :checked_out
    end

    event :checkin do
      transitions from: [:checked_out], to: :available
    end
  end

  def build_loan(attributes = {})
    loans.create({
      due_date: Date.today + default_loan_length_days.days
    }.merge(attributes))
  end

  def display_name
    [manufacturer, model].reject(&:blank?).join(' ')
  end

  def outstanding_loan
    loans.outstanding.last
  end
end
