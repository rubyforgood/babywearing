# frozen_string_literal: true

class Organization < ApplicationRecord
  validates_presence_of :name, :subdomain
  validates_uniqueness_of :name, :subdomain, case_sensitive: false

  validates :subdomain, subdomain: true

  has_many :locations
  has_many :users

  scope :nonadmin, -> { where.not("subdomain = ?", 'admin') }

  def admin?
    subdomain == "admin"
  end
end
