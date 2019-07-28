class Agreement < ApplicationRecord
  validates_presence_of :title, :content

  def signed?(user_id)
    SignedAgreement.where(agreement_id: id, user_id: user_id).present?
  end
end
