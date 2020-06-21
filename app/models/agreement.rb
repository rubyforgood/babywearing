# frozen_string_literal: true

class Agreement < ApplicationRecord
  acts_as_tenant(:organization)
  belongs_to :organization

  has_many :signed_agreements
  has_many :versions, dependent: :destroy, class_name: 'AgreementVersion'

  validates_presence_of :name
  validates_uniqueness_to_tenant(:name, case_sensitive: false)

  def active_version
    versions.where(active: true).first
  end
end
