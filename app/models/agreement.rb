# frozen_string_literal: true

class Agreement < ApplicationRecord
  acts_as_tenant(:organization)
  belongs_to :organization

  has_many :signed_agreements

  validates_presence_of :title, :content

  def signed_by?(user)
    signed_agreements.where(user: user).present?
  end
end
