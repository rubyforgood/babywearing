class Location < ApplicationRecord
  has_many :carriers
  belongs_to :organization
  validates_presence_of :name
end
