# frozen_string_literal: true

class SignedAgreement < ApplicationRecord
  belongs_to :user
  belongs_to :agreement

  validates :signature, presence: true
end
