class Cart < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  has_many :loans

  def line_items
    loans
  end
end
