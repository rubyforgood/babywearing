# frozen_string_literal: true
require 'active_support/concern'

module Deactivable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(deactivated_at: nil) }
    scope :inactive, -> { where.not(deactivated_at: nil) }
  end

  def deactivate
    touch :deactivated_at
  end

  def deactivated?
    deactivated_at.present?
  end

  def activate
    update deactivated_at: nil
  end

  def activated?
    deactivated_at.nil?
  end
end
