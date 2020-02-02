# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :membership_type

  before_validation :ensure_expiration

  validate :check_expiration

  validates_presence_of :effective

  def expired?
    expiration < Time.zone.today
  end

  private

  def ensure_expiration
    return if expiration.present? || membership_type.nil? || effective.nil?

    self.expiration = effective + membership_type.duration_days.days
  end

  def check_expiration
    return if expiration.nil? || effective.nil?
    return if expiration >= effective

    errors.add(:expiration, "cannot be before effective date")
  end
end
