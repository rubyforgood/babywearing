# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :carriers
  has_many :subcategories, class_name: "Category",
                           foreign_key: "parent_id"

  belongs_to :parent, class_name: "Category", optional: true
end
