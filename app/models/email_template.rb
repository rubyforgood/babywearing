# frozen_string_literal: true

class EmailTemplate < ApplicationRecord
  acts_as_tenant(:organization)

  PLACEHOLDERS = {
    '%CARRIER_NAME%' => 'Name of checked out carrier',
    '%DUE_DATE%' => 'Due date of carrier',
    '%USER_NAME%' => 'First name of user receiving email'
  }.freeze

  validates_presence_of :name, :type

  scope :active, -> { where(active: true) }

  # so subclasses will use the same policy
  def self.policy_class
    EmailTemplatePolicy
  end
end
