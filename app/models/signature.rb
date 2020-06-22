# frozen_string_literal: true

class Signature < ApplicationRecord
  belongs_to :user
  belongs_to :agreement_version

  validates_presence_of :signature, :signed_at

  scope :active, -> { joins(:agreement_version).where('agreement_versions.active = ?', true) }
end
