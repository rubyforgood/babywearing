# frozen_string_literal: true

class Loan < ApplicationRecord
  # relationships
  belongs_to :carrier
  belongs_to :member, class_name: "User"
  belongs_to :checkout_volunteer, class_name: 'User', default: -> { Current.user }
  belongs_to :checkin_volunteer, class_name: 'User', optional: true

  scope :outstanding, -> { where(checkin_volunteer_id: nil) }
  scope :overdue, -> { where(checkin_volunteer_id: nil).where(due_date.lt(Time.zone.today)) }
  scope :due_today, -> { where(due_date: Time.zone.today) }
  scope :due_in_one_week, -> { where(due_date: (Time.zone.today + 1.week)) }

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
