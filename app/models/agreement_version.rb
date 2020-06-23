# frozen_string_literal: true

class AgreementVersion < ApplicationRecord
  belongs_to :agreement
  belongs_to :last_modified_by, class_name: 'User'

  has_many :signatures, dependent: :destroy

  before_destroy :active_indestructable

  validates_presence_of :title, :content, :version
  validates_uniqueness_of :version, scope: :agreement_id, case_sensitive: false

  scope :active, -> { where(active: true) }
  validates :active, uniqueness: {
    conditions: -> { active },
    scope: :agreement,
    message: 'cannot have more than one active version per agreement'
  }

  def copy_content
    active_version = agreement.active_version
    if active_version
      self.title = active_version.title
      self.content = active_version.content
    else
      inactive_version = agreement.versions.where(active: false).order(created_at: :desc).first
      if inactive_version
        self.title = inactive_version.title
        self.content = inactive_version.content
      end
    end
  end

  private

  def active_indestructable
    errors.add(:base, 'Cannot destroy active version.') if active?
    throw(:abort) if errors.any?
  end
end
