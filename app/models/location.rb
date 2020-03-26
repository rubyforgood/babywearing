# frozen_string_literal: true

class Location < ApplicationRecord
  acts_as_tenant(:organization)

  has_many :carriers
  validates_presence_of :name
end
