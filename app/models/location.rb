class Location < ApplicationRecord
  has_many :carriers

  validates_presence_of :name
end
