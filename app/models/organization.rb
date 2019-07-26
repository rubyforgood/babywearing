class Organization < ApplicationRecord
  validates :name, presence: true
end
