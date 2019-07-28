class Organization < ApplicationRecord
  validates :name, presence: true
  has_many :locations
  has_many :carriers, through: :locations
end
