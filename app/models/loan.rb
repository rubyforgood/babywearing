# frozen_string_literal: true

class Loan < ApplicationRecord
  # relationships
  belongs_to :carrier
  belongs_to :member, class_name: "User"
  belongs_to :checkout_volunteer, class_name: 'User'
  belongs_to :checkin_volunteer, class_name: 'User', optional: true

  # validations
  validates :carrier, :due_date, presence: true

  # callbacks
  before_validation :set_due_date, on: :create

  def set_due_date
    self.due_date = carrier.default_loan_length_days.days.from_now.to_date if due_date.nil?
  end

  # public instance methods
  def checkin(volunteer)
    update(checkin_volunteer: volunteer, returned_at: Time.now.utc)
  end
end
