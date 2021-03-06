# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_tenant(:organization)
  include User::FilterImpl

  has_person_name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  validates :first_name, :last_name, :street_address, :city,
            :state, :postal_code, :phone_number, presence: true

  # we can remove these below and reimplement :validateable
  # if they ever merge: https://github.com/heartcombo/devise/pull/5094
  validates_presence_of :email
  validates_uniqueness_of :email, scope: :organization_id
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, allow_blank: true,
                              if: :email_changed?
  validates_format_of :phone_number, with: /\A\d{10}\z/, message: 'must be 10 digits.'

  validates_format_of :postal_code, with: /\A\d{5}\z/, message: 'should be a valid 5 digit number.'
  validates_presence_of :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of :password, within: 8..100, allow_blank: true

  before_validation :scrub_phone_number

  has_many :loans, foreign_key: 'borrower_id', dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :signatures, dependent: :destroy

  enum role: %i[admin volunteer user]

  scope :admins, -> { where(role: admin) }
  scope :volunteers, -> { where(role: :volunteer) }

  scope :with_current_membership, lambda {
    t = Time.zone.today
    distinct.left_joins(:memberships).where('memberships.expiration >= ? and '\
                                        'memberships.effective <= ? and '\
                                        'memberships.blocked = ?', t, t, false)
  }

  scope :with_expired_membership, lambda {
    distinct.left_joins(:memberships).where('memberships.expiration < ?', Time.zone.today)
  }

  scope :without_membership, lambda {
    left_outer_joins(:memberships).where(memberships: { id: nil })
  }

  # see https://github.com/heartcombo/devise/wiki/How-to:-Scope-login-to-subdomain
  def self.find_for_authentication(warden_conditions)
    where(email: warden_conditions[:email], organization_id: warden_conditions[:organization_id]).first
  end

  def self.to_csv
    attributes = %w[first_name last_name email phone_number created_at]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
  end

  def active_signatures
    signatures.active
  end

  def current_membership
    today = Time.zone.today
    membership = memberships.where(
      'expiration >= ? AND effective <= ? and blocked= ?', today, today, false
    ).order(expiration: :desc).first
    return if membership.nil?

    membership
  end

  def latest_membership
    memberships.order(expiration: :desc).first
  end

  def loans_available_to_member?
    return unless current_membership

    allowed_loans = current_membership.membership_type.number_of_items
    outstanding_loans = loans&.count

    allowed_loans > outstanding_loans
  end

  def send_welcome_email
    WelcomeMailer.welcome_email(id).deliver_later
  end

  def name_with_membership
    membership = memberships.last
    return name.full if membership.nil?

    s = "#{name.full} - #{membership.membership_type.short_name}"
    s += ' (Expired)' if membership.expired?
    s
  end

  def unsigned_agreements
    AgreementVersion.joins(:agreement).active
                    .where('agreements.organization_id = ?', organization_id)
                    .where.not(id: active_signatures.pluck(:agreement_version_id))
  end

  private

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def scrub_phone_number
    self.phone_number = phone_number&.delete('^0-9')
  end
end
