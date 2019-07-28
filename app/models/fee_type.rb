class FeeType < ApplicationRecord
  validates_presence_of :name, :amount
end
