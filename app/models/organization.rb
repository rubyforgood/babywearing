# frozen_string_literal: true

class Organization < ApplicationRecord
  validates_presence_of :name, :subdomain
  validates_uniqueness_of :name, :subdomain, case_sensitive: false

  validates_format_of :phone, with: /\A\d{10}\z/, message: 'must be 10 digits.', allow_nil: true

  before_destroy :admin_indestructable

  validates :subdomain, subdomain: true

  before_validation :scrub_phone

  has_many :agreements, dependent: :destroy
  has_many :carriers, dependent: :destroy
  has_many :fee_types, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :membership_types, dependent: :destroy

  scope :nonadmin, -> { where.not('subdomain = ?', 'admin') }

  def admin?
    subdomain == 'admin'
  end

  private

  def admin_indestructable
    errors.add(:base, 'Cannot delete admin organization.') if admin?
    throw(:abort) if errors.any?
  end

  def scrub_phone
    self.phone = phone&.delete('^0-9')
  end
end
