# frozen_string_literal: true

class Loan < ApplicationRecord
  include Loan::FilterImpl

  belongs_to :carrier
  belongs_to :borrower, class_name: 'User', optional: true, inverse_of: :loans # see presence validation below
  belongs_to :checkout_volunteer, class_name: 'User', default: -> { Current.user }
  belongs_to :checkin_volunteer, class_name: 'User', optional: true

  scope :outstanding, -> { where(returned_on: nil) }
  scope :overdue, -> { where(checkin_volunteer_id: nil).where(due_date.lt(Time.zone.today)) }
  scope :due_today, -> { where(due_date: Time.zone.today) }
  scope :due_in_one_week, -> { where(due_date: (Time.zone.today + 1.week)) }

  validates :carrier, :due_date, presence: true
  validates :borrower, presence: { message: 'must be selected' }
  validate :current_membership
  validate :loans_available_to_member
  validate :signed_agreements

  after_create :checkout_carrier
  after_save :checkin_carrier

  before_validation :set_due_date, on: :create

  def set_due_date
    self.due_date = carrier.default_loan_length_days.days.from_now.to_date if due_date.nil?
  end

  def outstanding?
    checkin_volunteer.nil?
  end

  private

  def current_membership
    errors.add(:member, 'does not have a current membership.') unless borrower&.current_membership
  end

  def loans_available_to_member
    # a checkin is also a loan event and we always want to allow return
    return if returned_on || borrower.nil?

    msg = 'already has maximum number of carriers checked out.'
    errors.add(:member, msg) unless borrower.loans_available_to_member?
  end

  def checkin_carrier
    carrier.checkin! if returned_on.present? && carrier.checked_out?
  end

  def checkout_carrier
    carrier.checkout!
  end

  def signed_agreements
    errors.add(:member, 'has agreements needing signature.') if borrower&.unsigned_agreements&.any?
  end
end
