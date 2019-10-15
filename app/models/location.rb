# frozen_string_literal: true

class Location < ApplicationRecord
  has_many :carriers
  validates_presence_of :name
end
