class Agreement < ApplicationRecord
  has_many :signed_agreements

  validates_presence_of :title, :content

  def signed_by?(user)
    signed_agreements.where(user: user).present?
  end
end
