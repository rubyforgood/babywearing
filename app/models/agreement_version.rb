# frozen_string_literal: true

class AgreementVersion < ApplicationRecord
  belongs_to :agreement
  belongs_to :last_modified_by, class_name: 'User'

  before_destroy :active_indestructable

  validates_presence_of :title, :content, :version

  scope :active, -> { where(active: true) }
  validates :active, uniqueness: {
    conditions: -> { active },
    scope: :agreement,
    message: 'cannot have more than one active version per agreement'
  }

  private

  def active_indestructable
    errors.add(:base, 'Cannot destroy active version.') if active?
    throw(:abort) if errors.any?
  end
end
